import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raki_internet_cafe/components/product-section.dart';
import 'package:raki_internet_cafe/providers/category-provider.dart';
import 'package:raki_internet_cafe/providers/product-page-view-provider.dart';

class ProductContentSection extends StatelessWidget {
  const ProductContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductPageViewProvider pageProvider = context
        .watch<ProductPageViewProvider>();
    final categories = context.watch<CategoryProvider>().categories;

    return Flexible(
      flex: 5,
      child: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => ProductSection(),
        itemCount: categories.length,
        controller: pageProvider.pageController,
      ),
    );
  }
}
