import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:raki_internet_cafe/helper/db-helper.dart';
import 'package:raki_internet_cafe/helper/document-helper.dart';
import 'package:raki_internet_cafe/helper/folder-helper.dart';
import 'package:raki_internet_cafe/models/product-model.dart';
import 'package:raki_internet_cafe/repository/product-repository.dart';

class EditProductProvider extends ChangeNotifier {
  Product? _product;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final price = TextEditingController();
  final variantLabel = TextEditingController();
  XFile? imageFile;
  bool isLoading = false;

  void initializeFields(Product product) {
    name.text = product.name;
    price.text = product.price.toString();
    variantLabel.text = product.variantLabel;
    imageFile = XFile(product.imagePath);
    _product = product;
  }

  void pickImage() async {
    imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    notifyListeners();
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Category name is required";
    }
    return null;
  }

  String? validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return "Price is required";
    }
    if (double.tryParse(value) == null) {
      return "Invalid price format";
    }
    return null;
  }

  String? validateVariantLabel(String? value) {
    if (value == null || value.isEmpty) {
      return "Variant label is required";
    }
    return null;
  }

  void resetProvider() async {
    name.clear();
    price.clear();
    variantLabel.clear();
    imageFile = null;
    isLoading = false;
    notifyListeners();
  }

  void setLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  Future<bool> editProduct(int categoryId) async {
    setLoading(true);
    if (!formKey.currentState!.validate()) return false;
    if (imageFile == null) return false;

    final database = await DBHelper.instance.database;
    final repo = ProductRepository(database: database);
    final docHelper = DocumentHelper.instance;

    String path = '';
    if (imageFile != null && imageFile!.path != _product!.imagePath) {
      path = await docHelper.saveImageToLocalDirectory(
        pickedFile: imageFile!,
        folderName: FolderHelper.categoryFolder,
      );
    }

    final product = Product(
      id: _product!.id,
      name: name.text,
      imagePath: path.isNotEmpty ? path : _product!.imagePath,
      catId: categoryId,
      variantLabel: variantLabel.text,
      price: double.tryParse(price.text) ?? 0,
    );

    final success = await repo.update(product);

    if (success) {
      setLoading(false);
      return true;
    }
    setLoading(false);
    return false;
  }
}
