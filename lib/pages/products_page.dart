import 'package:flutter/material.dart';
import 'package:project_state_store/components/app_drawer.dart';
import 'package:project_state_store/components/product_item.dart';
import 'package:project_state_store/utils/app_routes.dart';
import 'package:provider/provider.dart';

import '../models/product_list.model.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

Future <void> _refreshProduct(BuildContext context){
return Provider.of<ProductList>(context, listen: false).loadProducts();
}

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);

    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.ADD_PRODUCT);
            },
            icon: const Icon(Icons.add))
      ], title: const Text('Gerenciar produtos')),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProduct(context),
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
                itemCount: products.itemsCount,
                itemBuilder: (ctx, i) => Column(
                      children: [
                        ProductItem(product: products.items[i]),
                        const Divider()
                      ],
                    ))),
      ),
    );
  }
}
