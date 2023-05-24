// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:project_state_store/models/cart.model.dart';
import 'package:project_state_store/models/cart_item.model.dart';
import 'package:project_state_store/models/order.dart';

import '../utils/constants.dart';

class OrderList with ChangeNotifier {
  String _token;
  String _userId;
  List<Order> _items = [];

  OrderList([this._token = '', this._userId = '', this._items = const []]);


  List<Order> get items {
    return [..._items];
  }

  int get itemCount {
    return _items.length;
  }

  Future<void> loadOrders() async {
    List<Order> items = [];

    final response = await http
        .get(Uri.parse('${Constants.ORDER_BASE_URL}/$_userId.json?auth=$_token'));

    if (response.body == 'null') {
      return;
    }

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((orderId, orderData) {
      items.add(Order(
          id: orderId,
          total: orderData["total"],
          date: DateTime.parse(orderData["date"]),
          products: (orderData["products"] as List<dynamic>).map((item) {
            return CartItemModel(
                id: item["id"],
                productId: item["productId"],
                name: item["name"],
                quantity: item["quantity"],
                price: item["price"]);
          }).toList()));
    });

    _items = items.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();

    final response = await http.post(
      Uri.parse('${Constants.ORDER_BASE_URL}/$_userId.json?auth=$_token'),
      body: jsonEncode(
        {
          "total": cart.totalAmount,
          "products": cart.items.values
              .map((cartItem) => {
                    "id": cartItem.id,
                    "productId": cartItem.productId,
                    "name": cartItem.name,
                    "quantity": cartItem.quantity,
                    "price": cartItem.price,
                  })
              .toList(),
          "date": date.toIso8601String()
        },
      ),
    );

    final id = jsonDecode(response.body)["name"];

    _items.insert(
        0,
        Order(
            id: id,
            total: cart.totalAmount,
            products: cart.items.values.toList(),
            date: date));
    notifyListeners();
  }
}
