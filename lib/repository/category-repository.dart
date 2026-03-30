import 'package:sqflite/sqflite.dart';

import '../models/category-model.dart';

class CategoryRepository {
  final Database database;
  CategoryRepository({required this.database});

  Future<void> insert(Category category) async {
    await database.insert(
      CategoryFillable.table,
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
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
