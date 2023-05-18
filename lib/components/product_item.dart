import 'package:flutter/material.dart';
import 'package:project_state_store/models/products.model.dart';
import 'package:project_state_store/utils/app_routes.dart';
import 'package:provider/provider.dart';

import '../models/product_list.model.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);

    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(product.imageUrl)),
      title: Text(product.name),
      trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.ADD_PRODUCT, arguments: product);
                },
                icon: const Icon(Icons.edit),
                color: Theme.of(context).colorScheme.primary,
              ),
              IconButton(
                  onPressed: () => showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                                title: const Text('Tem certeza?'),
                                content: const Text(
                                    'Deseja remover o item do carrinho'),
                                actions: [
                                  TextButton(
                                    child: const Text('Não'),
                                    onPressed: () =>
                                        Navigator.of(ctx).pop(false),
                                  ),
                                  TextButton(
                                    child: const Text('Sim'),
                                    onPressed: () =>
                                        Navigator.of(ctx).pop(true),
                                  ),
                                ],
                              )).then((value) async {
                        if (value ?? false) {
                          try{
                              await Provider.of<ProductList>(
                            context,
                            listen: false,
                          ).deleteProduct(product);
                          }
                          catch(error){
                           msg.showSnackBar(SnackBar(content: Text(error.toString())));
                          }
                        }
                      }),
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).colorScheme.error)
            ],
          )),
    );
  }
}
