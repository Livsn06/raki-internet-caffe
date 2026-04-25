import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raki_internet_cafe/components/primary-button.dart';
import 'package:raki_internet_cafe/models/category-model.dart';
import 'package:raki_internet_cafe/providers/category-provider.dart';
import 'package:raki_internet_cafe/providers/edit-category-provider.dart';
import 'package:raki_internet_cafe/utils/gap.dart';

class EditCategoryScreen extends StatefulWidget {
  const EditCategoryScreen({super.key, required this.category});

  final Category category;

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EditCategoryProvider>().initialize(widget.category);
  }

  @override
  Widget build(BuildContext context) {
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
      padding: const EdgeInsets.all(12.0),
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Form(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                InkWell(
                  onTap: () =>
                      isLoading ? null : editCategoryProvider.pickImage(),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.black,
                    backgroundImage: image != null
                        ? FileImage(File(image.path))
                        : null,
                    child: image == null
                        ? const Icon(Icons.camera_alt, color: Colors.white)
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

                vGap(16),
                PrimaryButton(
                  label: "Update Category",
                  isLoading: isLoading,
                  onTap: update,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
