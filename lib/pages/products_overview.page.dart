import 'package:flutter/material.dart';
import 'package:project_state_store/components/product_grid.dart';
import 'package:project_state_store/components/product_quantity.dart';
import 'package:project_state_store/models/cart.model.dart';
import 'package:project_state_store/models/product_list.model.dart';
import 'package:provider/provider.dart';

enum FilterOptions { favorite, all }

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({super.key});

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
    bool showFavoriteOnly = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Minha Loja'), actions: [
        PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: (value){
              setState(() {
              if(value == FilterOptions.favorite){
                showFavoriteOnly = true;
              }
              else{
                showFavoriteOnly = false;
              }
              });
            },
            itemBuilder: (_) => [
                  const PopupMenuItem(
                      value: FilterOptions.favorite, child: Text('Favoritos')),
                  const PopupMenuItem(
                      value: FilterOptions.all, child: Text('Todos')),
                ]),
        Consumer<Cart>(
          builder: (ctx, cart,child) => ProductQuantity(
              value: cart.itemsCount.toString(),
              child: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.shopping_cart))),
        )
      ]),
      body: ProductGrid(showFavoriteOnly),
    );
  }
}
