import 'package:flutter/material.dart';
import 'package:project_state_store/components/app_drawer.dart';
import 'package:project_state_store/components/order.dart';
import 'package:project_state_store/models/order_list.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderList = Provider.of<OrderList>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Meus Pedidos')),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: orderList.itemCount,
        itemBuilder: (context, i) => OrderWidget(order: orderList.items[i])),
    );
  }
}
