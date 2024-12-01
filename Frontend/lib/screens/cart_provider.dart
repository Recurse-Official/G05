import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final Map<String, int> _cartItems = {}; // Key: Product ID, Value: Quantity

  Map<String, int> get cartItems => _cartItems;

  void addItem(String productId) {
    if (_cartItems.containsKey(productId)) {
      _cartItems[productId] = _cartItems[productId]! + 1;
    } else {
      _cartItems[productId] = 1;
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    if (_cartItems.containsKey(productId) && _cartItems[productId]! > 1) {
      _cartItems[productId] = _cartItems[productId]! - 1;
    } else {
      _cartItems.remove(productId);
    }
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
