import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raki_internet_cafe/components/primary-button.dart';
import 'package:raki_internet_cafe/core/ui-colors.dart';
import 'package:raki_internet_cafe/providers/category-provider.dart';
import 'package:raki_internet_cafe/providers/create-category-provider.dart';
import 'package:raki_internet_cafe/utils/gap.dart';

class CreateCategoryScreen extends StatelessWidget {
  const CreateCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const _green = Color(0xFF2E7D32);
    return Scaffold(
      backgroundColor: UIColors.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.read<CreateCategoryProvider>().resetProvider();
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Create Category",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: _green,
      ),
      body: CreateCategoryScreenBody(),
    );
  }
}

class CreateCategoryScreenBody extends StatelessWidget {
  const CreateCategoryScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    const _green = Color(0xFF2E7D32);
    final categoryProvider = context.read<CategoryProvider>();
    final createCategoryProvider = context.watch<CreateCategoryProvider>();
    final image = context.watch<CreateCategoryProvider>().imageFile;
    final formKey = context.watch<CreateCategoryProvider>().formKey;
    final categoryName = context.watch<CreateCategoryProvider>().name;
    final isLoading = context.watch<CreateCategoryProvider>().isLoading;

    void create() async {
      final success = await createCategoryProvider.createCategory();

      if (success) {
        await categoryProvider.refresh();
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Category created successfully!")),
        );
      } else {
        createCategoryProvider.setLoading(false);
        if (!context.mounted) return;
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
                        isLoading ? null : createCategoryProvider.pickImage(),
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
                        createCategoryProvider.validateName(value),
                  ),
                  vGap(18),
                  PrimaryButton(
                    label: "Create",
                    isLoading: isLoading,
                    onTap: create,
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
