import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raki_internet_cafe/components/category-card.dart';
import 'package:raki_internet_cafe/providers/category-provider.dart';
import 'package:raki_internet_cafe/providers/product-page-view-provider.dart';

class ProductCategorySection extends StatelessWidget {
  const ProductCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final pageProvider = context.watch<ProductPageViewProvider>();
    final categoryProvider = context.watch<CategoryProvider>();
    final categories = context.watch<CategoryProvider>().categories;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Determine responsive grid properties based on screen size
    int crossAxisCount = 1;
    double childAspectRatio = 0.9;

    if (screenWidth > 1200) {
      crossAxisCount = 2;
      childAspectRatio = 0.75;
    } else if (screenWidth > 900) {
      crossAxisCount = 1;
      childAspectRatio = 0.85;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Colors.grey)),
      ),
      child: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) => LayoutBuilder(
          builder: (context, constraints) {
            return InkWell(
              onTap: () {
                categoryProvider.setSelectedCategory(categories[index].id);
                pageProvider.jumpToPage(index);
              },
              child: CategoryCard(
                categories: categories,
                index: index,
                pageProvider: pageProvider,
                cardWidth: constraints.maxWidth,
                cardHeight: constraints.maxHeight,
              ),
            );
          },
        ),
      ),
    );
  }
}
