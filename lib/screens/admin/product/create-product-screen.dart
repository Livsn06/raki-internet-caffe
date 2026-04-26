import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raki_internet_cafe/components/primary-button.dart';
import 'package:raki_internet_cafe/core/ui-colors.dart';
import 'package:raki_internet_cafe/models/category-model.dart';
import 'package:raki_internet_cafe/providers/create-product-provider.dart';
import 'package:raki_internet_cafe/providers/product-provider.dart';
import 'package:raki_internet_cafe/utils/gap.dart';

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key, required this.category});
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.read<CreateProductProvider>().resetProvider();
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Create Item",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: CreateProductScreenBody(category: category),
    );
  }
}

class CreateProductScreenBody extends StatelessWidget {
  const CreateProductScreenBody({super.key, required this.category});
  final Category category;
  @override
  Widget build(BuildContext context) {
    final productProvider = context.read<ProductProvider>();
    final createProductProvider = context.watch<CreateProductProvider>();
    final image = context.watch<CreateProductProvider>().imageFile;
    final formKey = context.watch<CreateProductProvider>().formKey;
    final productName = context.watch<CreateProductProvider>().name;
    final price = context.watch<CreateProductProvider>().price;
    final variantLabel = context.watch<CreateProductProvider>().variantLabel;
    final isLoading = context.watch<CreateProductProvider>().isLoading;

    void create() async {
      final success = await createProductProvider.createProduct(category.id);

      if (success) {
        await productProvider.refresh();
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product created successfully!")),
        );
      } else {
        if (!context.mounted) return;
        context.read<CreateProductProvider>().setLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              image == null
                  ? "Image is required!"
                  : "Failed to create product!",
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
                      isLoading ? null : createProductProvider.pickImage(),
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
                  controller: productName,
                  decoration: const InputDecoration(
                    label: Text("Product Name"),
                  ),
                  validator: (value) =>
                      createProductProvider.validateName(value),
                ),
                vGap(16),
                TextFormField(
                  controller: price,
                  decoration: const InputDecoration(label: Text("Price")),
                  validator: (value) =>
                      createProductProvider.validatePrice(value),
                ),
                vGap(16),
                TextFormField(
                  controller: variantLabel,
                  decoration: const InputDecoration(
                    label: Text("Variant Label"),
                  ),
                  validator: (value) =>
                      createProductProvider.validateVariantLabel(value),
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
