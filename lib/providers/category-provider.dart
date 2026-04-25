import 'package:flutter/material.dart';
import 'package:raki_internet_cafe/helper/db-helper.dart';
import 'package:raki_internet_cafe/models/category-model.dart';
import 'package:raki_internet_cafe/repository/category-repository.dart';

class CategoryProvider extends ChangeNotifier {
  int _selectedCategoryId = 1;

  List<Category> _categories = [];

  int get selectedCategoryId => _selectedCategoryId;
  List<Category> get categories => _categories;

  void setCategories(List<Category> newCategories) {
    _categories = newCategories;
    notifyListeners();
  }

  void setSelectedCategory(int catId) {
    _selectedCategoryId = catId;
    notifyListeners();
  }

  Future<void> refresh() async {
    final database = await DBHelper.instance.database;
    final repo = CategoryRepository(database: database);
    // await Future.delayed(Duration(seconds: 5));
    _categories = await repo.getAll();
    notifyListeners();
  }

  Future<bool> deleteCategory(int catId) async {
    final database = await DBHelper.instance.database;
    final repo = CategoryRepository(database: database);
    return await repo.delete(catId);
  }
}
