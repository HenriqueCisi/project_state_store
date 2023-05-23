import 'package:flutter/material.dart';
import 'package:project_state_store/models/auth.dart';
import 'package:project_state_store/models/cart.model.dart';
import 'package:project_state_store/models/order_list.dart';
import 'package:project_state_store/models/product_list.model.dart';
import 'package:project_state_store/pages/auth_or_home_page.dart';
import 'package:project_state_store/pages/cart.page.dart';
import 'package:project_state_store/pages/orders_page.dart';
import 'package:project_state_store/pages/product_detail.page.dart';
import 'package:project_state_store/pages/product_form_page.dart';
import 'package:project_state_store/pages/products_page.dart';
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
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList(),
          update: (ctx, auth, previous) {
            return ProductList(auth.token ?? '', auth.userId ?? '', previous?.items ?? []);
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (_) => OrderList('', []),
          update: (ctx, auth, previous) {
            return OrderList(auth.token ?? '', previous?.items ?? []);
          },
        ),
        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            fontFamily: 'Lato',
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                .copyWith(
                    secondary: Colors.deepOrange, tertiary: Colors.white)),
        routes: {
          AppRoutes.AUTH_OR_HOME: (context) => const AuthOrHomepage(),
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
