import 'package:flutter/material.dart';
import 'package:raki_internet_cafe/models/category-model.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get categories => _categories;

  void setCategories(List<Category> newCategories) {
    _categories = newCategories;
    notifyListeners();
  }
}
