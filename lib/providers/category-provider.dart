import 'package:flutter/material.dart';
import 'package:raki_internet_cafe/models/category-model.dart';

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
}
