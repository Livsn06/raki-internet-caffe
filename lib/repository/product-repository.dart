import 'package:raki_internet_cafe/models/product-model.dart';
import 'package:sqflite/sqflite.dart';

class ProductRepository {
  final Database database;
  ProductRepository({required this.database});

  Future<void> insert(Product product) async {
    await database.insert(
      ProductFillable.table,
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Product>> getAll() async {
    final List<Map<String, dynamic>> maps = await database.query(
      ProductFillable.table,
    );
    return List.generate(maps.length, (i) => Product.fromMap(maps[i]));
  }
}
