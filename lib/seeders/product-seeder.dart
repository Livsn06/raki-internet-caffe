import 'dart:developer';

import 'package:raki_internet_cafe/helper/db-helper.dart';
import 'package:raki_internet_cafe/models/product-model.dart';
import 'package:raki_internet_cafe/repository/product-repository.dart';
import 'package:sqflite/sqflite.dart';

class ProductSeeder {
  ProductSeeder._();

  static List<Product> _hotCoffees = [
    Product(
      id: 1,
      catId: 1,
      name: 'Classic Arabica',
      imagePath: 'assets/images/icedcoffee.jpg',
      variantLabel: '8oz',
      price: 45,
    ),
    Product(
      id: 2,
      catId: 1,
      name: 'Classic Arabica',
      imagePath: 'assets/images/hotcoffee.jpg',
      variantLabel: '16oz',
      price: 55.0,
    ),
    Product(
      id: 3,
      catId: 1,
      name: 'Cafe Latte',
      imagePath: 'assets/images/icedcoffee.jpg',
      variantLabel: '8oz',
      price: 59,
    ),
    Product(
      id: 4,
      catId: 1,
      name: 'Cafe Latte',
      imagePath: 'assets/images/icedcoffee.jpg',
      variantLabel: '16oz',
      price: 69,
    ),
  ];

  static List<Product> _icedCoffees = [
    Product(
      id: 1,
      catId: 2,
      name: 'Iced Latte',
      imagePath: 'assets/images/icedcoffee.jpg',
      variantLabel: '16oz',
      price: 39.0,
    ),
    Product(
      id: 2,
      catId: 2,
      name: 'Iced Mocha',
      imagePath: 'assets/images/icedcoffee.jpg',
      variantLabel: '16oz',
      price: 49.0,
    ),
    Product(
      id: 2,
      catId: 2,
      name: 'Iced Brown Sugar Latte',
      imagePath: 'assets/images/icedcoffee.jpg',
      variantLabel: '16oz',
      price: 49.0,
    ),
  ];

  static List<Product> _getProducts() {
    return [..._hotCoffees, ..._icedCoffees];
  }

  static Future<void> seed() async {
    final dbHelper = DBHelper.instance;
    log('Seeding products...');
    final Database db = await dbHelper.database;
    final repository = ProductRepository(database: db);
    //
    for (var product in _getProducts()) {
      await repository.insert(product);
    }
    log('Products seeded.');
  }
}
