import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_state_store/exceptions/http_exception.dart';
import 'package:project_state_store/utils/constants.dart';

class Product with ChangeNotifier{
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  final _baseUrl = Constants.PRODUCT_BASE_URL;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false}
  );

  Future<void> toogleFavorite(String product) async {
    isFavorite = !isFavorite;
    notifyListeners();

    final response = await http.patch(Uri.parse('$_baseUrl/$product.json'),
        body: jsonEncode({
          "isFavorite": isFavorite,
        }));

    if (response.statusCode >= 400) {
      isFavorite = !isFavorite;
      notifyListeners();

      throw HttpException(
          msg: 'Não foi possível favoritar o arquivo',
          statusCode: response.statusCode);
    }
  }
}
