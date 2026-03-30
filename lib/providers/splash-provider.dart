import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raki_internet_cafe/helper/db-helper.dart';
import 'package:raki_internet_cafe/providers/category-provider.dart';
import 'package:raki_internet_cafe/providers/product-provider.dart';
import 'package:raki_internet_cafe/repository/category-repository.dart';
import 'package:raki_internet_cafe/repository/product-repository.dart';

class SplashProvider with ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  void initializeApp(BuildContext context) async {
    DBHelper dbHelper = DBHelper.instance;
    final db = await dbHelper.database;
    final categoryRepo = CategoryRepository(database: db);
    final productRepo = ProductRepository(database: db);

    final categories = await categoryRepo.getAll();
    final products = await productRepo.getAll();

    if (context.mounted) {
      final categoryProvider = Provider.of<CategoryProvider>(
        context,
        listen: false,
      );
      final productProvider = Provider.of<ProductProvider>(
        context,
        listen: false,
      );
      categoryProvider.setCategories(categories);
      productProvider.setProducts(products);
    }

    await Future.delayed(Duration(seconds: 3));
    _isLoading = false;
    notifyListeners();
  }
}
