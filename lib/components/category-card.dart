import 'package:flutter/material.dart';
import 'package:raki_internet_cafe/core/ui-colors.dart';
import 'package:raki_internet_cafe/models/category-model.dart';
import 'package:raki_internet_cafe/providers/product-page-view-provider.dart';
import 'package:raki_internet_cafe/utils/gap.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.categories,
    required this.index,
    required this.pageProvider,
    required this.cardWidth,
    required this.cardHeight,
  });
  final ProductPageViewProvider pageProvider;
  final List<Category> categories;
  final int index;
  final double cardWidth;
  final double cardHeight;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        border: Border.all(
          color: pageProvider.currentIndex == index
              ? UIColors.secondaryColor
              : UIColors.backgroundColor,
        ),
        borderRadius: BorderRadius.circular(8.0),
        color: pageProvider.currentIndex == index
            ? UIColors.secondaryColor.withValues(alpha: 0.2)
            : Colors.white,
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.asset(
                categories[index].imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          vGap(8),
          Text(
            categories[index].name,
            style: TextStyle(
              color: Colors.black,
              fontSize: cardWidth / 8,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
