import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_state_store/models/cart_item.model.dart';
import 'package:project_state_store/models/products.model.dart';

class Cart with ChangeNotifier {
  Map<String, CartItemModel> _items = {};

  Map<String, CartItemModel> get items {
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
          (value) => CartItemModel(
              id: value.id,
              productId: value.productId,
              name: value.name,
              quantity: value.quantity + 1,
              price: value.price));
      notifyListeners();
    } else {
      _items.putIfAbsent(
          product.id,
          () => CartItemModel(
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

  void removeItemFromSnackbarInteraction(String productId){
    if (!_items.containsKey(productId)){
      return;
    }

    if(_items[productId]?.quantity == 1){
      _items.remove(productId);
    }
    else {
      _items.update(
          productId,
          (item) => CartItemModel(
              id: item.id,
              productId: item.productId,
              name: item.name,
              quantity: item.quantity - 1,
              price: item.price));
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
