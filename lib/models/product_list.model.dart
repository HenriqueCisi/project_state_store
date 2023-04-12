import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_state_store/data/dummy_data.dart';
import 'package:project_state_store/models/products.model.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  int get itemsCount {
    return _items.length;
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void deleteProduct(Product product) {
    int index = _items.indexWhere((element) => element.id == product.id);

    if (index >= 0) {
    _items.removeWhere((prod) => product.id == prod.id);
    notifyListeners();
    }

  }


  void updateProduct(Product product) {
    int index = _items.indexWhere((element) => element.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
        id: hasId ? data['id'] as String : Random().nextDouble().toString(),
        name: data['name'] as String,
        description: data['description'] as String,
        price: data['price'] as double,
        imageUrl: data['imgUrl'] as String);

    hasId ? updateProduct(product) : addProduct(product);
  }
}
