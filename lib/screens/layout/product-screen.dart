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
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine responsive grid properties based on screen size
    int categoryFlex = 1;
    int contentFlex = 5;

    if (screenWidth > 600) {
      categoryFlex = 1;
      contentFlex = 5;
    } else {
      categoryFlex = 2;
      contentFlex = 5;
    }
    const _green = Color(0xFF2E7D32);
    return Scaffold(
      backgroundColor: UIColors.backgroundColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Menu",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: _green,
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
              children: [
                Expanded(flex: categoryFlex, child: ProductCategorySection()),
                Expanded(flex: contentFlex, child: ProductContentSection()),
              ],
            ),
          ),
          const CartSection(),
        ],
      ),
    );
  }
}
