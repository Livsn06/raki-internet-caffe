import 'package:flutter/material.dart';
import 'package:raki_internet_cafe/core/ui-colors.dart';

class CartSection extends StatelessWidget {
  const CartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      width: double.infinity,
      color: Colors.black,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: UIColors.tertiaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: () {},
        label: const Text("View Cart"),
        icon: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
