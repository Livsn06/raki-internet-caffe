import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raki_internet_cafe/core/ui-colors.dart';
import 'package:raki_internet_cafe/models/cart-item-model.dart';
import 'package:raki_internet_cafe/providers/cart-provider.dart';
import 'package:raki_internet_cafe/providers/category-provider.dart';
import 'package:raki_internet_cafe/providers/product-provider.dart';

class ProductSection extends StatefulWidget {
  const ProductSection({super.key});

  @override
  State<ProductSection> createState() => _ProductSectionState();
}

class _ProductSectionState extends State<ProductSection> {
  String selectedVariant = 'All';

  @override
  Widget build(BuildContext context) {
    final categoryID = context.watch<CategoryProvider>().selectedCategoryId;
    final productProvider = context.read<ProductProvider>();

    final selectedProducts = productProvider.getProductsByCategory(categoryID);
    final variants = [
      'All',
      ...{for (var product in selectedProducts) product.variantLabel},
    ];

    if (!variants.contains(selectedVariant)) {
      selectedVariant = 'All';
    }

    final filteredProducts = selectedVariant == 'All'
        ? selectedProducts
        : selectedProducts
              .where((product) => product.variantLabel == selectedVariant)
              .toList();

    final cartProvider = context.read<CartProvider>();

    if (selectedProducts.isEmpty) {
      return const Center(child: Text("No products found."));
    }

    // Determine responsive grid properties based on screen size
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = 2;
    double childAspectRatio = 0.7;

    if (screenWidth < 600) {
      crossAxisCount = 1;
      childAspectRatio = 0.65;
    } else if (screenWidth < 900) {
      crossAxisCount = 2;
      childAspectRatio = 0.7;
    } else if (screenWidth < 1200) {
      crossAxisCount = 3;
      childAspectRatio = 0.75;
    } else {
      crossAxisCount = 4;
      childAspectRatio = 0.8;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (variants.length > 1)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 10.0,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: variants.map((variant) {
                  final isSelected = selectedVariant == variant;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(variant),
                      selected: isSelected,
                      selectedColor: UIColors.secondaryColor.withValues(
                        alpha: 0.3,
                      ),
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: isSelected
                            ? UIColors.secondaryColor
                            : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: BorderSide(
                          color: isSelected
                              ? UIColors.secondaryColor
                              : Colors.grey.withOpacity(0.6),
                        ),
                      ),
                      onSelected: (_) {
                        setState(() {
                          selectedVariant = variant;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: childAspectRatio,
            ),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) => LayoutBuilder(
              builder: (context, constraints) {
                double scale = constraints.maxWidth / 130;
                final product = filteredProducts[index];
                final isInCart = context.watch<CartProvider>().isInCart(
                  product.id,
                );
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
                              child: Image.file(
                                File(product.imagePath),
                                fit: BoxFit.cover,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize:
                                              14 * scale, // Responsive font
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        product.variantLabel,
                                        style: TextStyle(
                                          fontSize:
                                              11 * scale, // Responsive font
                                          color: UIColors.tertiaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Responsive Button
                                  InkWell(
                                    onTap: isInCart
                                        ? null
                                        : () {
                                            final newItem = CartItem(
                                              id: DateTime.now()
                                                  .millisecondsSinceEpoch,
                                              productId: product.id,
                                              productName: product.name,
                                              productImagePath:
                                                  product.imagePath,
                                              variantLabel:
                                                  product.variantLabel,
                                              price: product.price,
                                              quantity: 1,
                                            );
                                            cartProvider.addToCart(newItem);
                                          },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 6 * scale,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isInCart
                                            ? Colors.grey.shade300
                                            : UIColors.secondaryColor
                                                  .withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(
                                          4 * scale,
                                        ),
                                        border: Border.all(
                                          color: isInCart
                                              ? Colors.grey
                                              : UIColors.secondaryColor,
                                          width: 1,
                                        ),
                                      ),
                                      child: Text(
                                        isInCart ? "Added" : "Add",
                                        style: TextStyle(
                                          fontSize:
                                              12 * scale, // Responsive font
                                          color: isInCart
                                              ? Colors.grey.shade700
                                              : UIColors.secondaryColor,
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
                        top:
                            constraints.maxHeight *
                            0.3, // 40% down from the top
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
                            "₱${product.price.toStringAsFixed(0)}",
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
          ),
        ),
      ],
    );
  }
}
