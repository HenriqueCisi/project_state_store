import 'package:flutter/material.dart';
import 'package:project_state_store/models/auth.dart';
import 'package:project_state_store/pages/auth_page.dart';
import 'package:project_state_store/pages/products_overview.page.dart';
import 'package:provider/provider.dart';

class AuthOrHomepage extends StatelessWidget {
  const AuthOrHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);

    return FutureBuilder(
        future: auth.tryAutoLogin(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return const Center(child: Text('Ocorreu um erro'));
          } else {
            return auth.isAuth
                ? const ProductsOverviewPage()
                : const AuthPage();
          }
        }));
  }
}
