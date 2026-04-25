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
