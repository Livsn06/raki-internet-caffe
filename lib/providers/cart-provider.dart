import 'package:flutter/material.dart';
import 'package:raki_internet_cafe/models/cart-item-model.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(CartItem item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void updateCartItem(CartItem item, int quantity) {
    final index = _cartItems.indexWhere(
      (cartItem) => cartItem.productId == item.productId,
    );
    if (index != -1) {
      _cartItems[index].quantity = quantity;
      notifyListeners();
    }
  }

  void removeFromCart(CartItem item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  bool isInCart(int productId) {
    return _cartItems.any((item) => item.productId == productId);
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
