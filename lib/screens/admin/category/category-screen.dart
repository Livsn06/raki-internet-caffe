import 'dart:io';

import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:raki_internet_cafe/models/category-model.dart';
import 'package:raki_internet_cafe/providers/category-provider.dart';
import 'package:raki_internet_cafe/screens/admin/category/create-category-screen.dart';
import 'package:raki_internet_cafe/screens/admin/category/edit-category-screen.dart';
import 'package:raki_internet_cafe/core/ui-colors.dart';
import 'package:raki_internet_cafe/screens/admin/product/product-list-screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.backgroundColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Categories",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: CategoryScreenBody(),
    );
  }
}

class CategoryScreenBody extends StatelessWidget {
  const CategoryScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = context.read<CategoryProvider>();
    final categories = context.watch<CategoryProvider>().categories;
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
                'All Categories',
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
                      builder: (context) => CreateCategoryScreen(),
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
              onRefresh: () async => categoryProvider.refresh(),
              child: categories.isEmpty
                  ? const Center(
                      child: Text(
                        "No categories found. Pull down to refresh.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return CategoryCard(category: categories[index]);
                      },
                      itemCount: categories.length,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});
  final Category category;
  //
  @override
  Widget build(BuildContext context) {
    final categoryProvider = context.read<CategoryProvider>();

    return Dismissible(
      key: ValueKey(category.id),
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
            title: const Text("Delete Category"),
            content: Text("Are you sure you want to delete ${category.name}?"),
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
        final isSuccess = await categoryProvider.deleteCategory(category.id);

        if (isSuccess) {
          categoryProvider.refresh();
          if (!context.mounted) return;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("${category.name} deleted!")));
        } else {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to delete ${category.name}!")),
          );
        }
      },
      child: Card(
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductListScreen(category: category),
              ),
            );
          },
          leading: CircleAvatar(
            backgroundImage: FileImage(File(category.imagePath)),
          ),
          title: Text(
            category.name,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditCategoryScreen(category: category),
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
