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

  // id 8-19
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

  // id 20-21
  static final List<Product> _hotdogs = [
    Product(
      id: 20,
      catId: 4,
      name: 'Hotdog Sandwich',
      imagePath: AssetHelper.getAssetPath(AssetItems.hotdogSandwich),
      variantLabel: 'Regular',
      price: 25.0,
    ),
    Product(
      id: 21,
      catId: 4,
      name: 'Hotdog Sandwich Overload',
      imagePath: AssetHelper.getAssetPath(AssetItems.hotdogSandwichOverload),
      variantLabel: 'With Meat',
      price: 65.0,
    ),
  ];

  // id 22
  static final List<Product> _fries = [
    Product(
      id: 22,
      catId: 5,
      name: 'Fries Cheese',
      imagePath: AssetHelper.getAssetPath(AssetItems.friesCheese),
      variantLabel: 'Regular',
      price: 25.0,
    ),
  ];

  // id 23-30
  static final List<Product> _milkTeas = [
    Product(
      id: 23,
      catId: 6,
      name: 'Milk Tea Cookies',
      imagePath: AssetHelper.getAssetPath(AssetItems.milkTeaCookies),
      variantLabel: 'Small',
      price: 35.0,
    ),
    Product(
      id: 24,
      catId: 6,
      name: 'Milk Tea Cookies',
      imagePath: AssetHelper.getAssetPath(AssetItems.milkTeaCookies),
      variantLabel: 'Large',
      price: 45.0,
    ),
    Product(
      id: 25,
      catId: 6,
      name: 'Milk Tea Dark Chocolate',
      imagePath: AssetHelper.getAssetPath(AssetItems.milkTeaDarkChocolate),
      variantLabel: 'Small',
      price: 35.0,
    ),
    Product(
      id: 26,
      catId: 6,
      name: 'Milk Tea Dark Chocolate',
      imagePath: AssetHelper.getAssetPath(AssetItems.milkTeaDarkChocolate),
      variantLabel: 'Large',
      price: 45.0,
    ),
    Product(
      id: 27,
      catId: 6,
      name: 'Milk Tea Hazelnut',
      imagePath: AssetHelper.getAssetPath(AssetItems.milkTeaHazelnut),
      variantLabel: 'Small',
      price: 35.0,
    ),
    Product(
      id: 28,
      catId: 6,
      name: 'Milk Tea Hazelnut',
      imagePath: AssetHelper.getAssetPath(AssetItems.milkTeaHazelnut),
      variantLabel: 'Large',
      price: 45.0,
    ),
    Product(
      id: 29,
      catId: 6,
      name: 'Milk Tea Taro',
      imagePath: AssetHelper.getAssetPath(AssetItems.milkTeaTaro),
      variantLabel: 'Small',
      price: 35.0,
    ),
    Product(
      id: 30,
      catId: 6,
      name: 'Milk Tea Taro',
      imagePath: AssetHelper.getAssetPath(AssetItems.milkTeaTaro),
      variantLabel: 'Large',
      price: 45.0,
    ),
  ];

  // id 31-36
  static final List<Product> _fruitSodas = [
    Product(
      id: 31,
      catId: 7,
      name: 'Blue Berry Soda',
      imagePath: AssetHelper.getAssetPath(AssetItems.fruitSoda),
      variantLabel: 'Medium',
      price: 40.0,
    ),
    Product(
      id: 32,
      catId: 7,
      name: 'Blue Berry Soda',
      imagePath: AssetHelper.getAssetPath(AssetItems.fruitSoda),
      variantLabel: 'Large',
      price: 50.0,
    ),
    Product(
      id: 33,
      catId: 7,
      name: 'Green Apple Soda',
      imagePath: AssetHelper.getAssetPath(AssetItems.fruitSoda),
      variantLabel: 'Medium',
      price: 40.0,
    ),
    Product(
      id: 34,
      catId: 7,
      name: 'Green Apple Soda',
      imagePath: AssetHelper.getAssetPath(AssetItems.fruitSoda),
      variantLabel: 'Large',
      price: 50.0,
    ),
    Product(
      id: 35,
      catId: 7,
      name: 'Strawberry Soda',
      imagePath: AssetHelper.getAssetPath(AssetItems.fruitSoda),
      variantLabel: 'Medium',
      price: 40.0,
    ),
    Product(
      id: 36,
      catId: 7,
      name: 'Strawberry Soda',
      imagePath: AssetHelper.getAssetPath(AssetItems.fruitSoda),
      variantLabel: 'Large',
      price: 50.0,
    ),
  ];

  static final List<Product> _milkShakes = [
    Product(
      id: 37,
      catId: 8,
      name: 'Chocolate Milkshake',
      imagePath: AssetHelper.getAssetPath(AssetItems.milkShakeChocolate),
      variantLabel: 'Small',
      price: 35.0,
    ),
    Product(
      id: 38,
      catId: 8,
      name: 'Chocolate Milkshake',
      imagePath: AssetHelper.getAssetPath(AssetItems.milkShakeChocolate),
      variantLabel: 'Medium',
      price: 45.0,
    ),
    Product(
      id: 39,
      catId: 8,
      name: 'Chocolate Milkshake',
      imagePath: AssetHelper.getAssetPath(AssetItems.milkShakeChocolate),
      variantLabel: 'Large',
      price: 55.0,
    ),
    Product(
      id: 40,
      catId: 8,
      name: 'Mango Milkshake',
      imagePath: AssetHelper.getAssetPath(AssetItems.milkShakeMango),
      variantLabel: 'Small',
      price: 35.0,
    ),
    Product(
      id: 41,
      catId: 8,
      name: 'Mango Milkshake',
      imagePath: AssetHelper.getAssetPath(AssetItems.milkShakeMango),
      variantLabel: 'Medium',
      price: 45.0,
    ),
    Product(
      id: 42,
      catId: 8,
      name: 'Mango Milkshake',
      imagePath: AssetHelper.getAssetPath(AssetItems.milkShakeMango),
      variantLabel: 'Large',
      price: 55.0,
    ),
    Product(
      id: 43,
      catId: 8,
      name: 'Melon Milkshake',
      imagePath: AssetHelper.getAssetPath(AssetItems.milkShakeMelon),
      variantLabel: 'Small',
      price: 35.0,
    ),
    Product(
      id: 44,
      catId: 8,
      name: 'Melon Milkshake',
      imagePath: AssetHelper.getAssetPath(AssetItems.milkShakeMelon),
      variantLabel: 'Medium',
      price: 45.0,
    ),
    Product(
      id: 45,
      catId: 8,
      name: 'Melon Milkshake',
      imagePath: AssetHelper.getAssetPath(AssetItems.milkShakeMelon),
      variantLabel: 'Large',
      price: 55.0,
    ),
    Product(
      id: 46,
      catId: 8,
      name: 'Ube Milkshake',
      imagePath: AssetHelper.getAssetPath(AssetItems.milkShakeUbe),
      variantLabel: 'Small',
      price: 35.0,
    ),
    Product(
      id: 47,
      catId: 8,
      name: 'Ube Milkshake',
      imagePath: AssetHelper.getAssetPath(AssetItems.milkShakeUbe),
      variantLabel: 'Medium',
      price: 45.0,
    ),
    Product(
      id: 48,
      catId: 8,
      name: 'Ube Milkshake',
      imagePath: AssetHelper.getAssetPath(AssetItems.milkShakeUbe),
      variantLabel: 'Large',
      price: 55.0,
    ),
  ];

  static List<Product> _getProducts() {
    return [
      ..._hotCoffees,
      ..._icedCoffees,
      ..._burgers,
      ..._hotdogs,
      ..._fries,
      ..._milkTeas,
      ..._fruitSodas,
      ..._milkShakes,
    ];
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
