// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/order.dart';
import 'package:shop/utils/util_functions.dart';

class OrderWidget extends StatelessWidget {
  final OrderModel order;
  const OrderWidget(
    this.order, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String data = DateFormat('dd/MM/yyyy hh:mm').format(order.date);
    String total = Utils.formatPrice(order.total.toDouble());
    return Card(
      child: ListTile(
        title: Text('$total'),
        subtitle: Text('$data'),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.expand_more,
          ),
        ),
      ),
    );
  }
}
