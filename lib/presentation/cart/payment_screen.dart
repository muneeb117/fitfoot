import 'package:fitfoot/main/navigation/routes/name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'provider/cart_provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Map<String, dynamic>? paymentIntentData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initiatePayment();
    });
  }

  Future<void> _initiatePayment() async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final totalPrice =
        cartProvider.totalPrice * 100; // Total price in paisa for PKR
    await makePayment(totalPrice.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text('Payment Screen',
            style: Theme.of(context).textTheme.titleSmall),
      ),
      body: Center(
        child: paymentIntentData == null
            ? const CircularProgressIndicator()
            : const Text("Processing Payment..."),
      ),
    );
  }

  Future<void> makePayment(int amount) async {
    try {
      // Create payment intent on Stripe server in PKR
      paymentIntentData = await createTestPaymentIntent(
          amount.toString(), 'pkr'); // Set currency to PKR

      // Initialize payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          googlePay: const PaymentSheetGooglePay(merchantCountryCode: 'PK'),
          style: ThemeMode.light,
          merchantDisplayName: 'Your Store',
        ),
      );

      // Display payment sheet
      await displayPaymentSheet();
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment initialization failed: $e')),
      );
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Payment Successful!")),
      );

      // Log sale in Firebase and clear the cart after payment
      await _addSaleToFirebase();

      // After the successful payment, clear the cart
      Provider.of<CartProvider>(context, listen: false).clearCart();

      // Navigate to the main application page after successful payment
      Navigator.pushReplacementNamed(context, AppRoutes.application);

      paymentIntentData = null;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment failed: $e")),
      );
    }
  }

  Future<Map<String, dynamic>> createTestPaymentIntent(
      String amount, String currency) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51Ow0DPP1qERhEAJyGcET5ECJnwCbePwFykzbnVwIGy7ajnOHqc0Ers3zVR5phs1wNPyXLVkmbyImlHR9iMSDEXeJ00lmYd1h7s', // Your Stripe secret key
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'amount': amount,
          'currency': currency,
          'payment_method_types[]': 'card',
        },
      );
      return jsonDecode(response.body);
    } catch (err) {
      print('Error creating PaymentIntent: $err');
      throw Exception('Failed to create PaymentIntent');
    }
  }

  Future<void> _addSaleToFirebase() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Log each product in the cart to Firebase
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      for (var cartItem in cartProvider.items) {
        DocumentReference productRef =
            firestore.collection('products').doc(cartItem.product.id);

        await firestore.runTransaction((transaction) async {
          DocumentSnapshot productSnapshot = await transaction.get(productRef);

          Map<String, dynamic>? productData =
              productSnapshot.data() as Map<String, dynamic>?;

          int currentSales =
              (productData != null && productData.containsKey('sales'))
                  ? productData['sales'] as int
                  : 0;

          transaction
              .update(productRef, {'sales': currentSales + cartItem.quantity});
        });

        await firestore.collection('sales_log').add({
          'product_id': cartItem.product.id,
          'product_name': cartItem.product.title,
          'amount': cartItem.product.price *
              cartItem.quantity, // Log the total amount for this item
          'timestamp': Timestamp.now(),
        });
      }
      //
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text("Sale added to Firebase")),
      // );
    } catch (e) {
      print("Error adding sale to Firebase: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add sale: $e")),
      );
    }
  }
}
