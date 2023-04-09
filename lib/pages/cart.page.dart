import 'package:flutter/material.dart';
import 'package:project_state_store/components/cart_item.dart';
import 'package:project_state_store/models/cart.model.dart';
import 'package:project_state_store/models/order_list.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Carrinho')),
      body: Column(children: [
        Card(
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total', style: TextStyle(fontSize: 20)),
                const SizedBox(
                  width: 10,
                ),
                Chip(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    label: Text(
                      'R\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headlineLarge
                              ?.color),
                    )),
                const Spacer(),
                TextButton(
                    onPressed: () {
                      Provider.of<OrderList>(context, listen: false).addOrder(cart);
                      cart.clear();
                    },
                    style: TextButton.styleFrom(
                        textStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary)),
                    child: const Text('Comprar'))
              ],
            ),
          ),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return CartItem(
                    cartItem: items[index],
                  );
                }))
      ]),
    );
  }
}
