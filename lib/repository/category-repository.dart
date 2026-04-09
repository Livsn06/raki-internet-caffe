import 'package:sqflite/sqflite.dart';

import '../models/category-model.dart';

class CategoryRepository {
  final Database database;
  CategoryRepository({required this.database});

  Future<bool> insert(Category category) async {
    final result = await database.insert(
      CategoryFillable.table,
      category.newItemMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return result > 0;
  }

  Future<int> insertAndReturnID(Category variety) async {
    final id = await database.insert(
      CategoryFillable.table,
      variety.newItemMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return id;
  }

  Future<List<Category>> getAll() async {
    final List<Map<String, dynamic>> maps = await database.query(
      CategoryFillable.table,
    );

    // log(maps.toString());
    return List.generate(maps.length, (i) {
      return Category.fromMap(maps[i]);
    });
  }
}
