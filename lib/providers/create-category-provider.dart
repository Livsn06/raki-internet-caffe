import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:raki_internet_cafe/helper/db-helper.dart';
import 'package:raki_internet_cafe/helper/document-helper.dart';
import 'package:raki_internet_cafe/helper/folder-helper.dart';
import 'package:raki_internet_cafe/models/category-model.dart';
import 'package:raki_internet_cafe/repository/category-repository.dart';

class CreateCategoryProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  XFile? imageFile;
  bool isLoading = false;

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
    name.clear();
    imageFile = null;
    isLoading = false;
    notifyListeners();
  }

  void setLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  Future<bool> createCategory() async {
    setLoading(true);
    if (!formKey.currentState!.validate()) return false;
    if (imageFile == null) return false;

    final database = await DBHelper.instance.database;
    final repo = CategoryRepository(database: database);
    final docHelper = DocumentHelper.instance;

    String path = '';
    if (imageFile != null) {
      path = await docHelper.saveImageToLocalDirectory(
        pickedFile: imageFile!,
        folderName: FolderHelper.categoryFolder,
      );
    }

    final category = Category(
      id: 0,
      name: name.text,
      imagePath: path,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );

    final success = await repo.insert(category);

    if (success) {
      resetProvider();
      return true;
    }

    return false;
  }
}
