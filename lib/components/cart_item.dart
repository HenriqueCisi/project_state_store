import 'package:flutter/material.dart';
import 'package:project_state_store/models/cart.model.dart';
import 'package:project_state_store/models/cart_item.model.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final CartItemModel cartItem;
  const CartItem({required this.cartItem, super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        Provider.of<Cart>(context, listen: false).removeItem(
          cartItem.productId,
        );
      },
      confirmDismiss: (_) {
        return showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text('Tem certeza?'),
                  content: const Text('Deseja remover o item do carrinho'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('Sim')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text('Não')),
                  ],
                ));
      },
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 25),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: ListTile(
            title: Text(cartItem.name),
            subtitle: Text("Total: R\$ ${cartItem.price * cartItem.quantity}"),
            trailing: Text("${cartItem.quantity}x"),
            leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: FittedBox(child: Text('${cartItem.price}')),
                )),
          ),
        ),
      ),
    );
  }
}
