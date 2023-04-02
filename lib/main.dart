import 'package:flutter/material.dart';
import 'package:project_state_store/pages/product_detail.page.dart';
import 'package:project_state_store/pages/products_overview.page.dart';
import 'package:project_state_store/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.deepOrange)),
      home: ProductsOverviewPage(),
      routes: {
        AppRoutes.PRODUCT_DETAIL: (context) => const ProductDetailPage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
