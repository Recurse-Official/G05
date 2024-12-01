import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Here are your orders!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
