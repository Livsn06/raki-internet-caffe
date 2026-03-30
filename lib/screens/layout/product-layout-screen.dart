import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raki_internet_cafe/components/category-card.dart';
import 'package:raki_internet_cafe/core/ui-colors.dart';
import 'package:raki_internet_cafe/providers/category-provider.dart';
import 'package:raki_internet_cafe/providers/product-page-view-provider.dart';
import 'package:raki_internet_cafe/providers/product-provider.dart';
import 'package:raki_internet_cafe/utils/gap.dart';

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
    final categoryProvider = context.watch<CategoryProvider>();
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
            crossAxisCount: 1, // Full width cards
            childAspectRatio: 0.9, // Nearly square
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // We use the constraints to determine if we are in a wide layout
                return InkWell(
                  onTap: () {
                    categoryProvider.setSelectedCategory(categories[index].id);
                    pageProvider.jumpToPage(index);
                  },
                  child: CategoryCard(
                    categories: categories,
                    index: index,
                    pageProvider: pageProvider,
                    // Pass a sizing factor if your CategoryCard supports it
                    cardWidth: constraints.maxWidth,
                    cardHeight: constraints.maxHeight,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ProductSection extends StatelessWidget {
  const ProductSection({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryID = context.watch<CategoryProvider>().selectedCategoryId;
    final productProvider = context.read<ProductProvider>();

    final selectedProducts = productProvider.getProductsByCategory(categoryID);

    if (selectedProducts.isEmpty) {
      return const Center(child: Text("No products found."));
    }

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemCount: selectedProducts.length,
      itemBuilder: (context, index) => LayoutBuilder(
        builder: (context, constraints) {
          double scale = constraints.maxWidth / 130;

          return Container(
            margin: const EdgeInsets.all(8.0),
            padding: EdgeInsets.all(4.0 * scale),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8.0 * scale),
              color: Colors.white,
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Section
                    Flexible(
                      flex: 3,
                      child: Center(
                        child: Image.asset(
                          AssetHelper.getAssetPath(AssetItems.appIcon),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    // Text and Button Section
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.all(8.0 * scale),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  selectedProducts[index].name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 14 * scale, // Responsive font
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  selectedProducts[index].variantLabel,
                                  style: TextStyle(
                                    fontSize: 11 * scale, // Responsive font
                                    color: UIColors.tertiaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            // Responsive Button
                            InkWell(
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                  vertical: 6 * scale,
                                ),
                                decoration: BoxDecoration(
                                  color: UIColors.secondaryColor.withValues(
                                    alpha: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    4 * scale,
                                  ),
                                  border: Border.all(
                                    color: UIColors.secondaryColor,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                    fontSize: 12 * scale, // Responsive font
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Price Badge - Positioned relative to card height
                Positioned(
                  top: constraints.maxHeight * 0.3, // 40% down from the top
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6 * scale,
                      vertical: 2 * scale,
                    ),
                    decoration: BoxDecoration(
                      color: UIColors.tertiaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4 * scale),
                        bottomLeft: Radius.circular(4 * scale),
                      ),
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: Text(
                      "₱${selectedProducts[index].price.toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 12 * scale, // Responsive font
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
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
