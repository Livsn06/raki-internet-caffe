import 'dart:io';

import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:raki_internet_cafe/core/routing-controls.dart';
import 'package:raki_internet_cafe/providers/category-provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

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
                'Categories',
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
                  RouteControls.push(
                    context,
                    RouteScreens.createProductCategoryScreen,
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
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: () {},
                      leading: CircleAvatar(
                        backgroundImage: FileImage(
                          File(categories[index].imagePath),
                        ),
                      ),
                      title: Text(
                        categories[index].name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.edit, color: Colors.black),
                      ),
                    ),
                  );
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
