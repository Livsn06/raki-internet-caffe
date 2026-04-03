import 'dart:developer';

import 'package:raki_internet_cafe/helper/asset-helper.dart';
import 'package:raki_internet_cafe/helper/db-helper.dart';
import 'package:raki_internet_cafe/models/product-model.dart';
import 'package:raki_internet_cafe/repository/product-repository.dart';
import 'package:sqflite/sqflite.dart';

class ProductSeeder {
  ProductSeeder._();
  // id 1-4
  static final List<Product> _hotCoffees = [
    Product(
      id: 1,
      catId: 1,
      name: 'Classic Arabica',
      imagePath: AssetHelper.getAssetPath(AssetItems.arabic),
      variantLabel: '8oz',
      price: 45,
    ),
    Product(
      id: 2,
      catId: 1,
      name: 'Classic Arabica',
      imagePath: AssetHelper.getAssetPath(AssetItems.arabic),
      variantLabel: '16oz',
      price: 55.0,
    ),
    Product(
      id: 3,
      catId: 1,
      name: 'Cafe Latte',
      imagePath: AssetHelper.getAssetPath(AssetItems.cafe),
      variantLabel: '8oz',
      price: 59,
    ),
    Product(
      id: 4,
      catId: 1,
      name: 'Cafe Latte',
      imagePath: AssetHelper.getAssetPath(AssetItems.cafe),
      variantLabel: '16oz',
      price: 69,
    ),
  ];

  // id 5-7
  static final List<Product> _icedCoffees = [
    Product(
      id: 5,
      catId: 2,
      name: 'Iced Latte',
      imagePath: AssetHelper.getAssetPath(AssetItems.icedLatte),
      variantLabel: '16oz',
      price: 39.0,
    ),
    Product(
      id: 6,
      catId: 2,
      name: 'Iced Mocha',
      imagePath: AssetHelper.getAssetPath(AssetItems.icedMocha),
      variantLabel: '16oz',
      price: 49.0,
    ),
    Product(
      id: 7,
      catId: 2,
      name: 'Iced Brown Sugar Latte',
      imagePath: AssetHelper.getAssetPath(AssetItems.icedBrownSugarLatte),
      variantLabel: '16oz',
      price: 49.0,
    ),
  ];

  static final List<Product> _burgers = [
    Product(
      id: 8,
      catId: 3,
      name: 'Classic Burger',
      imagePath: AssetHelper.getAssetPath(AssetItems.classicBurger),
      variantLabel: 'Regular',
      price: 30.0,
    ),
    Product(
      id: 9,
      catId: 3,
      name: 'Cheese Burger',
      imagePath: AssetHelper.getAssetPath(AssetItems.cheeseBurger),
      variantLabel: 'Regular',
      price: 35.0,
    ),
    Product(
      id: 10,
      catId: 3,
      name: 'Burger with Egg',
      imagePath: AssetHelper.getAssetPath(AssetItems.burgerWithEgg),
      variantLabel: 'Regular',
      price: 45.0,
    ),
    Product(
      id: 11,
      catId: 3,
      name: 'Burger Overload',
      imagePath: AssetHelper.getAssetPath(AssetItems.burgerOverload),
      variantLabel: '2 Patty, egg, fries',
      price: 80.0,
    ),

    // VARIANTS
    Product(
      id: 12,
      catId: 3,
      name: 'Classic Burger',
      imagePath: AssetHelper.getAssetPath(AssetItems.classicBurger),
      variantLabel: 'Buy 1 Take 1',
      price: 50.0,
    ),
    Product(
      id: 13,
      catId: 3,
      name: 'Classic Burger',
      imagePath: AssetHelper.getAssetPath(AssetItems.classicBurger),
      variantLabel: 'Buy 2 Take 1',
      price: 70.0,
    ),
    Product(
      id: 14,
      catId: 3,
      name: 'Burger with Egg',
      imagePath: AssetHelper.getAssetPath(AssetItems.burgerWithEgg),
      variantLabel: 'Buy 1 Take 1',
      price: 50.0,
    ),
    Product(
      id: 15,
      catId: 3,
      name: 'Burger with Egg',
      imagePath: AssetHelper.getAssetPath(AssetItems.burgerWithEgg),
      variantLabel: 'Buy 2 Take 1',
      price: 70.0,
    ),
    Product(
      id: 16,
      catId: 3,
      name: 'Cheese Burger',
      imagePath: AssetHelper.getAssetPath(AssetItems.cheeseBurger),
      variantLabel: 'Buy 1 Take 1',
      price: 60.0,
    ),
    Product(
      id: 17,
      catId: 3,
      name: 'Cheese Burger',
      imagePath: AssetHelper.getAssetPath(AssetItems.cheeseBurger),
      variantLabel: 'Buy 2 Take 1',
      price: 90.0,
    ),
    Product(
      id: 18,
      catId: 3,
      name: 'Burger with Egg',
      imagePath: AssetHelper.getAssetPath(AssetItems.burgerWithEgg),
      variantLabel: 'Buy 1 Take 1',
      price: 80.0,
    ),
    Product(
      id: 19,
      catId: 3,
      name: 'Burger with Egg',
      imagePath: AssetHelper.getAssetPath(AssetItems.burgerWithEgg),
      variantLabel: 'Buy 2 Take 1',
      price: 120.0,
    ),
  ];

  static List<Product> _getProducts() {
    return [..._hotCoffees, ..._icedCoffees, ..._burgers];
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
