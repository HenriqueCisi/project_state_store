import 'package:flutter/material.dart';
import 'package:project_state_store/models/cart.model.dart';
import 'package:project_state_store/models/order_list.dart';
import 'package:project_state_store/models/product_list.model.dart';
import 'package:project_state_store/pages/auth_page.dart';
import 'package:project_state_store/pages/cart.page.dart';
import 'package:project_state_store/pages/orders_page.dart';
import 'package:project_state_store/pages/product_detail.page.dart';
import 'package:project_state_store/pages/product_form_page.dart';
import 'package:project_state_store/pages/products_page.dart';
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
                .copyWith(secondary: const Color.fromARGB(255, 255, 255, 255))),
        routes: {
          AppRoutes.AUTH: (context) => const AuthPage(),
          AppRoutes.HOME: (context) => const ProductsOverviewPage(),
          AppRoutes.PRODUCT_DETAIL: (context) => const ProductDetailPage(),
          AppRoutes.CART: (context) => const CartPage(),
          AppRoutes.ORDERS: (context) => const OrdersPage(),
          AppRoutes.PRODUCTS: (context) => const ProductsPage(),
          AppRoutes.ADD_PRODUCT: (context) => const ProductFormPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
