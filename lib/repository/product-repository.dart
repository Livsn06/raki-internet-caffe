import 'package:raki_internet_cafe/models/product-model.dart';
import 'package:sqflite/sqflite.dart';

class ProductRepository {
  final Database database;
  ProductRepository({required this.database});

  Future<bool> insert(Product product) async {
    final result = await database.insert(
      ProductFillable.table,
      product.newItemMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return result > 0;
  }

  Future<bool> update(Product product) async {
    final result = await database.update(
      ProductFillable.table,
      product.toMap(),
      where: '${ProductFillable.id} = ?',
      whereArgs: [product.id],
    );

    return result > 0;
  }

  Future<List<Product>> getAll() async {
    final List<Map<String, dynamic>> maps = await database.query(
      ProductFillable.table,
    );
    return List.generate(maps.length, (i) => Product.fromMap(maps[i]));
  }

  Future<bool> delete(int productId) async {
    final result = await database.delete(
      ProductFillable.table,
      where: '${ProductFillable.id} = ?',
      whereArgs: [productId],
    );
    return result > 0;
  }
}
