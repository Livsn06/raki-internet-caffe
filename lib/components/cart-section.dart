import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raki_internet_cafe/core/ui-colors.dart';
import 'package:raki_internet_cafe/providers/cart-provider.dart';
import 'package:raki_internet_cafe/screens/client/cart-screen.dart';

class CartSection extends StatelessWidget {
  const CartSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    return Container(
      padding: const EdgeInsets.all(14.0),
      width: double.infinity,
      color: UIColors.backgroundColor,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: UIColors.tertiaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const CartScreen()));
        },
        label: Text("${cartProvider.cartItems.length} Cart"),
        icon: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
