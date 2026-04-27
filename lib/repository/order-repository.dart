import 'dart:developer';

import 'package:raki_internet_cafe/models/order-model.dart';
import 'package:sqflite/sqflite.dart';

class OrderRepository {
  final Database database;
  OrderRepository({required this.database});

  Future<bool> insert(Order order) async {
    final result = await database.insert(
      OrderFillable.table,
      order.newItemMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return result > 0;
  }

  Future<bool> update(Order order) async {
    final result = await database.update(
      OrderFillable.table,
      order.newItemMap(),
      where: '${OrderFillable.id} = ?',
      whereArgs: [order.id],
    );
    return result > 0;
  }

  Future<List<Order>> getAll() async {
    final List<Map<String, dynamic>> maps = await database.query(
      OrderFillable.table,
    );

    log(maps.toString());
    return List.generate(maps.length, (i) {
      return Order.fromMap(maps[i]);
    });
  }

  Future<bool> delete(int orderId) async {
    final result = await database.delete(
      OrderFillable.table,
      where: '${OrderFillable.id} = ?',
      whereArgs: [orderId],
    );
    return result > 0;
  }
}
