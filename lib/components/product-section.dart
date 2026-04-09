import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raki_internet_cafe/core/ui-colors.dart';
import 'package:raki_internet_cafe/providers/category-provider.dart';
import 'package:raki_internet_cafe/providers/product-provider.dart';

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
                          selectedProducts[index].imagePath,
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
