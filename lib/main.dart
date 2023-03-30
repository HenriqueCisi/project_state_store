import 'package:flutter/material.dart';
import 'package:project_state_store/pages/products_overview.page.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: ProductsOverviewPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
