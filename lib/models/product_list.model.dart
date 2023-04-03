import 'package:flutter/material.dart';
import 'package:project_state_store/data/dummy_data.dart';
import 'package:project_state_store/models/products.model.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

}
