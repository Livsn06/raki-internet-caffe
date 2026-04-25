import 'package:flutter/material.dart';
import 'package:raki_internet_cafe/core/ui-colors.dart';
import 'package:raki_internet_cafe/models/category-model.dart';
import 'package:raki_internet_cafe/screens/admin/edit-category-screen.dart';

class EditProductCategoryLayoutScreen extends StatelessWidget {
  const EditProductCategoryLayoutScreen({super.key, required this.category});
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.backgroundColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Edit Category",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: EditCategoryScreen(category: category),
    );
  }
}
