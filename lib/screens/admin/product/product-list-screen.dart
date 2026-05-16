import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raki_internet_cafe/core/ui-colors.dart';
import 'package:raki_internet_cafe/models/category-model.dart';
import 'package:raki_internet_cafe/models/product-model.dart';
import 'package:raki_internet_cafe/providers/product-provider.dart';
import 'package:raki_internet_cafe/screens/admin/product/create-product-screen.dart';
import 'package:raki_internet_cafe/screens/admin/product/edit-product-screen.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key, required this.category});
  final Category category;

  @override
  Widget build(BuildContext context) {
    const _green = Color(0xFF2E7D32);
    return Scaffold(
      backgroundColor: UIColors.backgroundColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          category.name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: _green,
      ),
      body: ProductListScreenBody(category: category),
    );
  }
}

class ProductListScreenBody extends StatefulWidget {
  const ProductListScreenBody({super.key, required this.category});
  final Category category;

  @override
  State<ProductListScreenBody> createState() => _ProductListScreenBodyState();
}

class _ProductListScreenBodyState extends State<ProductListScreenBody> {
  late PageController _pageController;
  int _selectedVariantIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().refresh();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.read<ProductProvider>();
    final products = context.watch<ProductProvider>().getProductsByCategory(
      widget.category.id,
    );

    final variants = <String>{};
    for (final p in products) {
      final v = (p.variantLabel ?? '').trim();
      if (v.isNotEmpty) variants.add(v);
    }
    final variantList = ['All', ...variants.toList()];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 760;
        return Container(
          padding: const EdgeInsets.all(12.0),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Text(
                    'Product Items',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      foregroundColor: Colors.white,
                    ),
                    label: const Text('New'),
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CreateProductScreen(category: widget.category),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 8),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(variantList.length, (i) {
                    final label = variantList[i];
                    final selected = i == _selectedVariantIndex;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(label),
                        selected: selected,
                        onSelected: (_) {
                          setState(() {
                            _selectedVariantIndex = i;
                          });
                          _pageController.animateToPage(
                            i,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        selectedColor: const Color(0xFFF57C00),
                        backgroundColor: Colors.grey.shade200,
                        labelStyle: TextStyle(
                          color: selected ? Colors.white : Colors.black87,
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 8),

              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _selectedVariantIndex = index);
                  },
                  itemCount: variantList.length,
                  itemBuilder: (context, pageIndex) {
                    final variant = variantList[pageIndex];
                    final filtered = variant == 'All'
                        ? products
                        : products
                              .where((p) => (p.variantLabel ?? '') == variant)
                              .toList();

                    if (filtered.isEmpty) {
                      return Center(
                        child: Text('No products found for "$variant"'),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async => productProvider.refresh(),
                      child: ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (context, index) =>
                            ProductCard(product: filtered[index]),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final Product product;
  //
  @override
  Widget build(BuildContext context) {
    final productProvider = context.read<ProductProvider>();

    return Dismissible(
      key: ValueKey(product.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.only(right: 20.0),
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) {
        return showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Delete Product"),
            content: Text("Are you sure you want to delete ${product.name}?"),
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: const Text("Delete"),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) async {
        final isSuccess = await productProvider.deleteProduct(product.id);

        if (isSuccess) {
          await productProvider.refresh();
          if (!context.mounted) return;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("${product.name} deleted!")));
        } else {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to delete ${product.name}!")),
          );
        }
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 12.0,
            ),
            child: Row(
              children: [
                // product image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: product.imagePath.isNotEmpty
                      ? Image.file(
                          File(product.imagePath),
                          width: 72,
                          height: 72,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 72,
                          height: 72,
                          color: Colors.grey.shade200,
                          child: Icon(Icons.image, color: Colors.grey.shade600),
                        ),
                ),
                const SizedBox(width: 12),
                // product details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          if ((product.variantLabel ?? '').isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                product.variantLabel,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          const SizedBox(width: 8),
                          Text(
                            '₱${product.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFF57C00),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // actions
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditProductScreen(product: product),
                          ),
                        );
                      },
                      icon: Icon(Icons.edit, color: Colors.grey.shade700),
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
