import 'package:flutter/material.dart';
import 'package:project_state_store/models/auth.dart';
import 'package:project_state_store/models/products.model.dart';
import 'package:project_state_store/utils/app_routes.dart';
import 'package:provider/provider.dart';

import '../models/cart.model.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({super.key});

  @override
  Widget build(BuildContext context) {
  final auth = Provider.of<Auth>(context, listen: false);
  final product = Provider.of<Product>(context, listen: false);
  final cart = Provider.of<Cart>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: Consumer<Product>(
              builder: (ctx, product, _) =>
                IconButton(
                onPressed: () {
                  product.toogleFavorite(product.id, auth.token ?? '');
                },
                icon:  Icon(product.isFavorite ? Icons.favorite: Icons.favorite_border),
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            title: Text(
              product.name,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                    content: const Text('Adicionado com sucesso!'),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(label: 'DESFAZER', onPressed: (){
                      cart.removeItemFromSnackbarInteraction(product.id);
                    }),)
                );
                cart.addItem(product);
              },
              icon: const Icon(Icons.shopping_cart),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUCT_DETAIL,arguments: product);
            },
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          )),
    );
  }
}
