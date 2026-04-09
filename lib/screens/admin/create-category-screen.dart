import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raki_internet_cafe/components/primary-button.dart';
import 'package:raki_internet_cafe/providers/category-provider.dart';
import 'package:raki_internet_cafe/providers/create-category-provider.dart';
import 'package:raki_internet_cafe/utils/gap.dart';

class CreateCategoryScreen extends StatelessWidget {
  const CreateCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = context.read<CategoryProvider>();
    final createCategoryProvider = context.watch<CreateCategoryProvider>();
    final image = context.watch<CreateCategoryProvider>().imageFile;
    final formKey = context.watch<CreateCategoryProvider>().formKey;
    final categoryName = context.watch<CreateCategoryProvider>().name;
    final isLoading = context.watch<CreateCategoryProvider>().isLoading;

    void create() async {
      final success = await createCategoryProvider.createCategory();
      if (!context.mounted) return;

      if (success) {
        await categoryProvider.refresh();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Category created successfully!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              image == null
                  ? "Image is required!"
                  : "Failed to create category!",
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
                      isLoading ? null : createCategoryProvider.pickImage(),
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
                      createCategoryProvider.validateName(value),
                ),

                vGap(16),
                PrimaryButton(
                  label: "Create",
                  isLoading: isLoading,
                  onTap: create,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
