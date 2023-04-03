import 'package:flutter/material.dart';
import 'package:project_state_store/components/product_grid.dart';
import 'package:project_state_store/models/product_list.model.dart';
import 'package:provider/provider.dart';

enum FilterOptions { favorite, all }

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Minha Loja'), actions: [
        PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: (value){
              if(value == FilterOptions.favorite){
                provider.showFavoriteOnly();
              }
              else{
                 provider.showAll();
              }
            },
            itemBuilder: (_) => [
                  const PopupMenuItem(
                      value: FilterOptions.favorite, child: Text('Favoritos')),
                  const PopupMenuItem(
                      value: FilterOptions.all, child: Text('Todos')),
                ])
      ]),
      body: const ProductGrid(),
    );
  }
}
