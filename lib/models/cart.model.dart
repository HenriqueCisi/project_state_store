import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_state_store/models/cart_item.model.dart';
import 'package:project_state_store/models/products.model.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
          product.id,
          (value) => CartItem(
              id: value.id,
              productId: value.productId,
              name: value.name,
              quantity: value.quantity + 1,
              price: value.price));
      notifyListeners();
    } else {
      _items.putIfAbsent(
          product.id,
          () => CartItem(
              id: Random().nextDouble().toString(),
              productId: product.id,
              name: product.name,
              quantity: 1,
              price: product.price));
      notifyListeners();
    }
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
