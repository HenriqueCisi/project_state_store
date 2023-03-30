import 'package:flutter/material.dart';
import 'package:project_state_store/components/product_item.dart';
import '../models/products.model.dart';
import '../data/dummy_data.dart';

class ProductsOverviewPage extends StatelessWidget {
  final List<Product> loadedProducts = dummyProducts;

  ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          return ProductItem(product: loadedProducts[index]);
        },
        itemCount: loadedProducts.length,
      ),
    );
  }
}
