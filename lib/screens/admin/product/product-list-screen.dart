import 'dart:io';

import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
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
    return Scaffold(
      backgroundColor: UIColors.backgroundColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          category.name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: ProductListScreenBody(category: category),
    );
  }
}

class ProductListScreenBody extends StatelessWidget {
  const ProductListScreenBody({super.key, required this.category});
  final Category category;
  @override
  Widget build(BuildContext context) {
    final productProvider = context.read<ProductProvider>();
    final products = context.watch<ProductProvider>().getProductsByCategory(
      category.id,
    );
    //
    return Container(
      padding: const EdgeInsets.all(12.0),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                'Product Items',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              TextButton.icon(
                label: const Text('New', style: TextStyle(color: Colors.black)),
                icon: const Icon(Icons.add, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CreateProductScreen(category: category),
                    ),
                  );
                },
              ),
            ],
          ),

          Divider(color: Colors.grey),

          Expanded(
            child: LiquidPullToRefresh(
              color: Colors.transparent,
              backgroundColor: Colors.black,
              onRefresh: () async => productProvider.refresh(),
              child: products.isEmpty
                  ? const Center(child: Text('No products found'))
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return ProductCard(product: products[index]);
                      },
                      itemCount: products.length,
                    ),
            ),
          ),
        ],
      ),
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
        child: ListTile(
          onTap: () {},
          leading: CircleAvatar(
            backgroundImage: FileImage(File(product.imagePath)),
          ),
          title: Text(
            product.name,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            "${product.variantLabel} - ₱${product.price.toStringAsFixed(2)}",
            style: const TextStyle(color: Colors.grey),
          ),
          trailing: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProductScreen(product: product),
                ),
              );
            },
            icon: Icon(Icons.edit, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
