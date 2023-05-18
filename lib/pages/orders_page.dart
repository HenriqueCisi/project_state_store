import 'package:flutter/material.dart';
import 'package:project_state_store/components/app_drawer.dart';
import 'package:project_state_store/components/order.dart';
import 'package:project_state_store/models/order_list.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  Future<void> _refreshOrders(BuildContext context) async {
    await Provider.of<OrderList>(context, listen: false).loadOrders();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Meus Pedidos')),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshOrders(context),
        child: FutureBuilder(
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Consumer<OrderList>(
                  builder: (ctx, orders, child) => ListView.builder(
                      itemCount: orders.itemCount,
                      itemBuilder: (context, i) =>
                          OrderWidget(order: orders.items[i])),
                );
              }
            },
            future: Provider.of<OrderList>(context, listen: false).loadOrders()),
      ),
    );
  }
}
