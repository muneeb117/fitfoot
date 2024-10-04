import 'package:flutter/material.dart';
import '../../../constants.dart';

class CartCounter extends StatefulWidget {
  final Function(int)? onQuantityChanged;  // Callback to notify quantity changes

  const CartCounter({Key? key, this.onQuantityChanged}) : super(key: key);

  @override
  State<CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numOfItems = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        // Decrement button
        buildCounterButton(
          icon: Icons.remove,
          press: () {
            if (numOfItems > 1) {
              setState(() {
                numOfItems--;
                widget.onQuantityChanged?.call(numOfItems);  // Notify parent
              });
            }
          },
        ),
        // Display the number of items
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin / 2),
          child: Text(
            numOfItems.toString().padLeft(2, "0"),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        // Increment button
        buildCounterButton(
          icon: Icons.add,
          press: () {
            setState(() {
              numOfItems++;
              widget.onQuantityChanged?.call(numOfItems);  // Notify parent
            });
          },
        ),
      ],
    );
  }

  // Helper function to build the counter button (plus/minus)
  SizedBox buildCounterButton({required IconData icon, required VoidCallback press}) {
    return SizedBox(
      width: 40,
      height: 40,  // Made the button square for symmetry
      child: OutlinedButton(
        onPressed: press,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        child: Center(  // Ensure the icon is centered inside the button
          child: Icon(
            icon,
            size: 20,  // Adjusted icon size to fit nicely inside the button
          ),
        ),
      ),
    );
  }
}
