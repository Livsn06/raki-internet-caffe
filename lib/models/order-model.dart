import 'dart:convert';
import 'package:raki_internet_cafe/models/cart-item-model.dart';

class OrderFillable {
  static const String table = 'orders';

  static const String id = 'id';
  static const String orderNumber = 'order_number';
  static const String totalPrice = 'total_price';
  static const String status = 'status';
  static const String items = 'items'; // JSON string
  static const String createdAt = 'created_at';
}

class Order {
  final int id;
  final int orderNumber;
  final double totalPrice;
  final String status;
  final List<CartItem> items;
  final String createdAt;

  Order({
    required this.id,
    required this.orderNumber,
    required this.totalPrice,
    required this.status,
    required this.items,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      OrderFillable.id: id,
      OrderFillable.orderNumber: orderNumber,
      OrderFillable.totalPrice: totalPrice,
      OrderFillable.status: status,
      OrderFillable.items: jsonEncode(
        items.map((item) => item.toMap()).toList(),
      ), // ✅ convert to JSON string
      OrderFillable.createdAt: createdAt,
    };
  }

  Map<String, dynamic> newItemMap() {
    return {
      OrderFillable.orderNumber: orderNumber,
      OrderFillable.totalPrice: totalPrice,
      OrderFillable.status: status,
      OrderFillable.items: jsonEncode(
        items.map((item) => item.toMap()).toList(),
      ), // ✅ convert to JSON string
      OrderFillable.createdAt: createdAt,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map[OrderFillable.id],
      orderNumber: map[OrderFillable.orderNumber],
      totalPrice: map[OrderFillable.totalPrice],
      status: map[OrderFillable.status],
      items: (jsonDecode(map[OrderFillable.items]) as List)
          .map((item) => CartItem.fromMap(item))
          .toList(),
      createdAt: map[OrderFillable.createdAt],
    );
  }
}
