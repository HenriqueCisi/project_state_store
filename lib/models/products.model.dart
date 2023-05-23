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

  final _baseUrl = Constants.USER_FAVORITE_URL;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false}
  );

  Future<void> toogleFavorite(
      String product, String token, String userId) async {
    isFavorite = !isFavorite;
    notifyListeners();

    final response =
        await http.put(Uri.parse('$_baseUrl/$userId/$product.json?auth=$token'),
            body: jsonEncode(isFavorite));

    if (response.statusCode >= 400) {
      isFavorite = !isFavorite;
      notifyListeners();

      throw HttpException(
          msg: 'Não foi possível favoritar o arquivo',
          statusCode: response.statusCode);
    }
  }
}
