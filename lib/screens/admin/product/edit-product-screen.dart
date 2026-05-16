import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raki_internet_cafe/components/primary-button.dart';
import 'package:raki_internet_cafe/core/ui-colors.dart';
import 'package:raki_internet_cafe/models/product-model.dart';
import 'package:raki_internet_cafe/providers/edit-product-provider.dart';
import 'package:raki_internet_cafe/providers/product-provider.dart';
import 'package:raki_internet_cafe/utils/gap.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    const _green = Color(0xFF2E7D32);
    return Scaffold(
      backgroundColor: UIColors.backgroundColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Edit Item",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: _green,
      ),
      body: EditProductScreenBody(product: product),
    );
  }
}

class EditProductScreenBody extends StatefulWidget {
  const EditProductScreenBody({super.key, required this.product});
  final Product product;

  @override
  State<EditProductScreenBody> createState() => _EditProductScreenBodyState();
}

class _EditProductScreenBodyState extends State<EditProductScreenBody> {
  @override
  void initState() {
    context.read<EditProductProvider>().initializeFields(widget.product);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.read<ProductProvider>();
    final editProductProvider = context.watch<EditProductProvider>();
    final image = context.watch<EditProductProvider>().imageFile;
    final formKey = context.watch<EditProductProvider>().formKey;
    final productName = context.watch<EditProductProvider>().name;
    final price = context.watch<EditProductProvider>().price;
    final variantLabel = context.watch<EditProductProvider>().variantLabel;
    final isLoading = context.watch<EditProductProvider>().isLoading;

    void edit() async {
      final success = await editProductProvider.editProduct();

      if (success) {
        await productProvider.refresh();
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product updated successfully!")),
        );
        Navigator.of(context).pop();
      } else {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              image == null
                  ? "Image is required!"
                  : "Failed to update product!",
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    const _green = Color(0xFF2E7D32);
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
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
                        isLoading ? null : editProductProvider.pickImage(),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: _green.withOpacity(0.12),
                      backgroundImage: image != null
                          ? FileImage(File(image.path))
                          : null,
                      child: image == null
                          ? Icon(Icons.camera_alt, color: _green)
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
                        editProductProvider.validateName(value),
                  ),
                  vGap(16),
                  TextFormField(
                    controller: price,
                    decoration: const InputDecoration(label: Text("Price")),
                    validator: (value) =>
                        editProductProvider.validatePrice(value),
                  ),
                  vGap(16),
                  TextFormField(
                    controller: variantLabel,
                    decoration: const InputDecoration(
                      label: Text("Variant Label"),
                    ),
                    validator: (value) =>
                        editProductProvider.validateVariantLabel(value),
                  ),
                  vGap(18),
                  PrimaryButton(
                    label: "Edit",
                    isLoading: isLoading,
                    onTap: edit,
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
