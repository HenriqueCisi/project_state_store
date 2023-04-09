import 'package:flutter/material.dart';
import 'package:project_state_store/components/product_grid_item.dart';
import 'package:project_state_store/models/product_list.model.dart';
import 'package:project_state_store/models/products.model.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
   final bool showFavoriteOnly;

   const ProductGrid(
    this.showFavoriteOnly, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts =
        showFavoriteOnly ? provider.favoriteItems : provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
            // ignore: prefer_const_constructors
            value: loadedProducts[index], child: ProductGridItem());
      },
      itemCount: loadedProducts.length,
    );
  }
}
