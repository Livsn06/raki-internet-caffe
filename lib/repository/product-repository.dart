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
}
