import 'dart:developer';

import 'package:raki_internet_cafe/helper/asset-helper.dart';
import 'package:raki_internet_cafe/helper/db-helper.dart';
import 'package:raki_internet_cafe/models/category-model.dart';
import 'package:raki_internet_cafe/repository/category-repository.dart';
import 'package:sqflite/sqflite.dart';

class CategorySeeder {
  CategorySeeder._();

  static List<Category> _getCategories() {
    return [
      Category(
        id: 1,
        name: 'Food/Snacks',
        imagePath: AssetHelper.getAssetPath(AssetItems.burgers),
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
      ),
      Category(
        id: 3,
        name: 'Hot Coffee',
        imagePath: AssetHelper.getAssetPath(AssetItems.hotCoffee),
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
      ),
      Category(
        id: 4,
        name: 'Iced Coffee',
        imagePath: AssetHelper.getAssetPath(AssetItems.icedCoffee),
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
      ),
      Category(
        id: 5,
        name: 'Milk Tea',
        imagePath: AssetHelper.getAssetPath(AssetItems.milkTea),
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
      ),
      Category(
        id: 6,
        name: 'Fruit Soda',
        imagePath: AssetHelper.getAssetPath(AssetItems.fruitSoda),
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
      ),
      Category(
        id: 7,
        name: 'Milk Shake',
        imagePath: AssetHelper.getAssetPath(AssetItems.milkShake),
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
      ),
    ];
  }

  static Future<void> seed() async {
    final dbHelper = DBHelper.instance;
    log('Seeding categories...');
    final Database db = await dbHelper.database;
    final repository = CategoryRepository(database: db);
    //
    for (var category in _getCategories()) {
      await repository.insert(category);
    }
    log('Categories seeded.');
  }
}
