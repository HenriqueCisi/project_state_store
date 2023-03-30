import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:project_state_store/models/products.model.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite),
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          )),
    );
  }
}
