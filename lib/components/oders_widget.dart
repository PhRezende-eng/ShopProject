// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/order.dart';

class OrderWidget extends StatelessWidget {
  final OrderModel order;
  const OrderWidget(
    this.order, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String data = DateFormat('dd/MM/yyyy hh:mm').format(order.date);
    return Card(
      child: ListTile(
        title: Text('R\$ ${order.total.toStringAsFixed(2)}'),
        subtitle: Text('$data'),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.more,
          ),
        ),
      ),
    );
  }
}
