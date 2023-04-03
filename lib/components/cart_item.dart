import 'package:flutter/material.dart';
import 'package:project_state_store/models/cart_item.model.dart';

class CartItem extends StatelessWidget {
  final CartItemModel cartItem;
  const CartItem({required this.cartItem, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(cartItem.name);
  }
}
