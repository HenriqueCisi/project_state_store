import 'package:flutter/material.dart';
import 'package:project_state_store/data/dummy_data.dart';
import 'package:project_state_store/models/products.model.dart';

class ProductList with ChangeNotifier {
  bool isFavoriteOnly = false;
  final List<Product> _items = dummyProducts;

  List<Product> get items {
    if(isFavoriteOnly){
     return _items.where((prod) => prod.isFavorite).toList();
    }
    else{
      return [..._items];
    }
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void showFavoriteOnly() {
    isFavoriteOnly = true;
    notifyListeners();
  }

  void showAll() {
    isFavoriteOnly = false;
    notifyListeners();
  }
}
