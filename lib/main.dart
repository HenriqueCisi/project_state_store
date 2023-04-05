import 'package:flutter/material.dart';
import 'package:project_state_store/models/cart.model.dart';
import 'package:project_state_store/models/order.dart';
import 'package:project_state_store/models/order_list.dart';
import 'package:project_state_store/models/product_list.model.dart';
import 'package:project_state_store/pages/cart.page.dart';
import 'package:project_state_store/pages/product_detail.page.dart';
import 'package:project_state_store/pages/products_overview.page.dart';
import 'package:project_state_store/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductList()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => OrderList())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            fontFamily: 'Lato',
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                .copyWith(secondary: Colors.deepOrange)),
        home: const ProductsOverviewPage(),
        routes: {
          AppRoutes.PRODUCT_DETAIL: (context) => const ProductDetailPage(),
          AppRoutes.CART: (context) => const CartPage()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
