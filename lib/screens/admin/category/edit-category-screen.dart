import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raki_internet_cafe/components/primary-button.dart';
import 'package:raki_internet_cafe/core/ui-colors.dart';
import 'package:raki_internet_cafe/models/category-model.dart';
import 'package:raki_internet_cafe/providers/category-provider.dart';
import 'package:raki_internet_cafe/providers/edit-category-provider.dart';
import 'package:raki_internet_cafe/utils/gap.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key, required this.category});
  final Category category;
  @override
  Widget build(BuildContext context) {
    const _green = Color(0xFF2E7D32);
    return Scaffold(
      backgroundColor: UIColors.backgroundColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Edit Category",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: _green,
      ),
      body: EditCategoryScreenBody(category: category),
    );
  }
}

class EditCategoryScreenBody extends StatefulWidget {
  const EditCategoryScreenBody({super.key, required this.category});

  final Category category;

  @override
  State<EditCategoryScreenBody> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreenBody> {
  @override
  void initState() {
    super.initState();
    context.read<EditCategoryProvider>().initialize(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    const _green = Color(0xFF2E7D32);
    final categoryProvider = context.read<CategoryProvider>();
    final editCategoryProvider = context.watch<EditCategoryProvider>();
    final image = context.watch<EditCategoryProvider>().imageFile;
    final formKey = context.watch<EditCategoryProvider>().formKey;
    final categoryName = context.watch<EditCategoryProvider>().name;
    final isLoading = context.watch<EditCategoryProvider>().isLoading;

    void update() async {
      final success = await editCategoryProvider.editCategory();

      if (success) {
        await categoryProvider.refresh();
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Category updated successfully!")),
        );
      } else {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              image == null
                  ? "Image is required!"
                  : "Failed to update category!",
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 16,
                ),
              ],
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () =>
                        isLoading ? null : editCategoryProvider.pickImage(),
                    child: CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.green.withOpacity(0.12),
                      backgroundImage: image != null
                          ? FileImage(File(image.path))
                          : null,
                      child: image == null
                          ? Icon(Icons.camera_alt, color: Colors.green)
                          : null,
                    ),
                  ),
                  vGap(16),
                  TextFormField(
                    controller: categoryName,
                    decoration: const InputDecoration(
                      label: Text("Category Name"),
                    ),
                    validator: (value) =>
                        editCategoryProvider.validateName(value),
                  ),
                  vGap(18),
                  PrimaryButton(
                    label: "Update Category",
                    isLoading: isLoading,
                    onTap: update,
                    backgroundColor: _green,
                    foregroundColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
