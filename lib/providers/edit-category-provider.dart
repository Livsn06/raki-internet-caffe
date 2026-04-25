import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:raki_internet_cafe/helper/db-helper.dart';
import 'package:raki_internet_cafe/helper/document-helper.dart';
import 'package:raki_internet_cafe/helper/folder-helper.dart';
import 'package:raki_internet_cafe/models/category-model.dart';
import 'package:raki_internet_cafe/repository/category-repository.dart';

class EditCategoryProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Category? _category;
  final name = TextEditingController();
  XFile? imageFile;
  bool isLoading = false;

  void initialize(Category category) {
    name.text = category.name;
    imageFile = XFile(category.imagePath);
    _category = category;
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

  void resetProvider() async {
    // name.clear();
    // imageFile = null;
    isLoading = false;
    notifyListeners();
  }

  void setLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  Future<bool> editCategory() async {
    setLoading(true);
    if (!formKey.currentState!.validate()) return false;
    if (imageFile == null) return false;

    final database = await DBHelper.instance.database;
    final repo = CategoryRepository(database: database);
    final docHelper = DocumentHelper.instance;

    String path = '';
    if (imageFile != null && imageFile!.path != _category!.imagePath) {
      path = await docHelper.saveImageToLocalDirectory(
        pickedFile: imageFile!,
        folderName: FolderHelper.categoryFolder,
      );
    }

    final category = Category(
      id: _category!.id,
      name: name.text,
      imagePath: path.isNotEmpty ? path : _category!.imagePath,
      createdAt: _category!.createdAt,
      updatedAt: DateTime.now().toIso8601String(),
    );

    final success = await repo.update(category);

    if (success) {
      resetProvider();
      return true;
    }

    return false;
  }
}
