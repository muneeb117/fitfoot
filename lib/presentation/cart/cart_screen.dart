import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../data/models/cart_models.dart';
import 'provider/cart_provider.dart';
import 'payment_screen.dart'; // Import your payment screen here

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart', style: Theme.of(context).textTheme.titleSmall),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/back.svg',
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: cartItems.isNotEmpty
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartItems[index];
                      return _buildCartItem(cartItem, cartProvider);
                    },
                  ),
                ),
                _buildCartTotal(cartProvider),
              ],
            )
          : Center(
              child: Text(
                "Your cart is empty",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
    );
  }

  // Build each cart item
  Widget _buildCartItem(CartItem cartItem, CartProvider cartProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(cartItem.product.image),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.product.title,
                  style: Theme.of(context).textTheme.labelMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                    "\Rs.${(cartItem.product.price * cartItem.quantity).toStringAsFixed(2)}", // Correct price calculation for quantity
                    style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(height: 5),
                _buildQuantityCounter(cartItem, cartProvider),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              cartProvider.removeFromCart(cartItem.product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${cartItem.product.title} removed from cart'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Build the quantity counter for each cart item
  Widget _buildQuantityCounter(CartItem cartItem, CartProvider cartProvider) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove, size: 20),
          onPressed: () {
            if (cartItem.quantity > 1) {
              cartProvider.updateQuantity(
                  cartItem.product, cartItem.quantity - 1);
            }
          },
        ),
        Text(
          cartItem.quantity.toString(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        IconButton(
          icon: const Icon(Icons.add, size: 20),
          onPressed: () {
            cartProvider.updateQuantity(
                cartItem.product, cartItem.quantity + 1);
          },
        ),
      ],
    );
  }

  // Build the total price and proceed button
  Widget _buildCartTotal(CartProvider cartProvider) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total:",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                "\Rs.${cartProvider.totalPrice.toStringAsFixed(2)}", // Total price for all products
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                PaymentScreen payment=PaymentScreen();
                // Navigate to the Payment Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentScreen(
                        // productId: cartProvider
                        //     .items.first.product.id, // First product for demo
                        // productName: cartProvider.items.first.product.title,
                        ),
                  ),
                );
              },
              child: Text(
                "Proceed to Checkout",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
