import 'package:flutter/material.dart';
import 'package:project_state_store/models/cart_item.model.dart';

class Order{
  final String id;
  final double total;
  final List<CartItemModel> products;
  final DateTime date;

  Order({
    required this.id,
    required this.total,
    required this.products,
    required this.date,
  });
}