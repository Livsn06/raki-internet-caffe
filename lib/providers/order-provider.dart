import 'package:flutter/material.dart';
import 'package:raki_internet_cafe/helper/db-helper.dart';
import 'package:raki_internet_cafe/models/cart-item-model.dart';
import 'package:raki_internet_cafe/models/order-model.dart';
import 'dart:math';

import 'package:raki_internet_cafe/repository/order-repository.dart';

class OrderProvider extends ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => _orders;
  late Order _order;
  Order get order => _order;

  final _random = Random();

  int generateOrderNumber() {
    final timePart = DateTime.now().millisecondsSinceEpoch % 1000;
    final randomPart = _random.nextInt(10);
    return int.parse('$timePart$randomPart');
  }

  void createOrder(List<CartItem> items, double totalPrice) async {
    _order = Order(
      id: 0,
      orderNumber: generateOrderNumber(),
      items: items,
      status: 'pending',
      createdAt: DateTime.now().toString(),
      totalPrice: totalPrice,
    );

    final database = await DBHelper.instance.database;
    final repo = OrderRepository(database: database);
    repo.insert(_order);
    notifyListeners();
  }

  Future<void> getAllOrders() async {
    final database = await DBHelper.instance.database;
    final repo = OrderRepository(database: database);
    final orders = await repo.getAll();
    _orders = orders;
    notifyListeners();
  }

  Future<bool> deleteOrder(int id) async {
    final database = await DBHelper.instance.database;
    final repo = OrderRepository(database: database);
    return await repo.delete(id);
  }

  Future<bool> updateOrderStatus(int id, String newStatus) async {
    final database = await DBHelper.instance.database;
    final repo = OrderRepository(database: database);
    return await repo.updateStatus(id, newStatus);
  }

  Future<void> refresh() async {
    await getAllOrders();
  }
}
