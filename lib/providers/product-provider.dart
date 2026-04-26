import 'package:flutter/material.dart';
import 'package:raki_internet_cafe/helper/db-helper.dart';
import 'package:raki_internet_cafe/models/product-model.dart';
import 'package:raki_internet_cafe/repository/product-repository.dart';

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

  Future<void> refresh() async {
    final database = await DBHelper.instance.database;
    final repo = ProductRepository(database: database);
    // await Future.delayed(Duration(seconds: 5));
    _products = await repo.getAll();
    notifyListeners();
  }

  Future<bool> deleteProduct(int productId) async {
    final database = await DBHelper.instance.database;
    final repo = ProductRepository(database: database);
    return await repo.delete(productId);
  }
}
