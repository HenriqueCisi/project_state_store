import 'package:flutter/material.dart';
import 'package:project_state_store/providers/counter_provider.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    final provider = CounterProvider.of(context)?.state;

    return Scaffold(
      appBar: AppBar(title: const Text('Exemplo Contador')),
      body: Column(
        children: [
          Text(provider?.value.toString() ?? '0'),
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  provider?.inc();
                });
              }),
          IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  provider?.dec();
                });
              }),
        ],
      ),
    );
  }
}
