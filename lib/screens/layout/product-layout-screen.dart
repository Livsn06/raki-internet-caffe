import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raki_internet_cafe/components/category-card.dart';
import 'package:raki_internet_cafe/core/ui-colors.dart';
import 'package:raki_internet_cafe/providers/category-provider.dart';
import 'package:raki_internet_cafe/providers/product-page-view-provider.dart';

import '../../helper/asset-helper.dart';

class ProductLayoutScreen extends StatelessWidget {
  const ProductLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Menu",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          Flexible(child: Row(children: [CategorySection(), ContentSection()])),
          const CartSection(),
        ],
      ),
    );
  }
}

class ContentSection extends StatelessWidget {
  const ContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final pageProvider = context.watch<ProductPageViewProvider>();
    final categories = context.watch<CategoryProvider>().categories;

    return Flexible(
      flex: 5,
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => ProductSection(),
        itemCount: categories.length,
        controller: pageProvider.pageController,
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final pageProvider = context.watch<ProductPageViewProvider>();
    final categories = context.watch<CategoryProvider>().categories;

    return Flexible(
      flex: 2,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(right: BorderSide(color: Colors.grey)),
        ),
        height: double.infinity,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => pageProvider.jumpToPage(index),
              child: CategoryCard(
                categories: categories,
                index: index,
                pageProvider: pageProvider,
              ),
            ),
          ),
          itemCount: categories.length,
        ),
      ),
    );
  }
}

class ProductSection extends StatelessWidget {
  const ProductSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                AssetHelper.getAssetPath(AssetItems.appIcon),
                fit: BoxFit.cover,
              ),
            ),
            const Text("Product name"),
            const Text("Price"),
          ],
        ),
      ),
      itemCount: 5,
    );
  }
}

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
