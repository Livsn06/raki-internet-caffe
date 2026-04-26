import 'package:flutter/material.dart';
import 'package:raki_internet_cafe/components/cart-section.dart';
import 'package:raki_internet_cafe/components/product-category-section.dart';
import 'package:raki_internet_cafe/components/product-content-section.dart';
import 'package:raki_internet_cafe/core/ui-colors.dart';
import 'package:raki_internet_cafe/screens/admin/auth-screen.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.backgroundColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Menu",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => AuthScreen()));
            },
            icon: const Icon(Icons.person, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: Row(
              children: [ProductCategorySection(), ProductContentSection()],
            ),
          ),
          const CartSection(),
        ],
      ),
    );
  }
}
