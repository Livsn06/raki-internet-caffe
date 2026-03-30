import 'package:flutter/material.dart';
import 'package:raki_internet_cafe/models/product-model.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  void setProducts(List<Product> newProducts) {
    _products = newProducts;
    notifyListeners();
  }

  List<Product> getProductsByCategory(int catId) {
    return _products.where((product) => product.catId == catId).toList();
  }
}
