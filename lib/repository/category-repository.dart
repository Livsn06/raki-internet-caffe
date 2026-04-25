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

  Future<bool> update(Category category) async {
    final result = await database.update(
      CategoryFillable.table,
      category.newItemMap(),
      where: '${CategoryFillable.id} = ?',
      whereArgs: [category.id],
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

  Future<bool> delete(int catId) async {
    final result = await database.delete(
      CategoryFillable.table,
      where: '${CategoryFillable.id} = ?',
      whereArgs: [catId],
    );
    return result > 0;
  }
}
