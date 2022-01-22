// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, sized_box_for_whitespace, unused_local_variable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/order.dart';
import 'package:shop/utils/util_functions.dart';

class OrderWidget extends StatefulWidget {
  final OrderModel order;
  const OrderWidget(
    this.order, {
    Key? key,
  }) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  late bool _expanded;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _expanded = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String data = DateFormat('dd/MM/yyyy hh:mm').format(widget.order.date);
    String total = Utils.formatPrice(widget.order.total.toDouble());

    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('$total'),
            subtitle: Text('$data'),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              icon: Icon(
                Icons.expand_more,
              ),
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              margin: EdgeInsets.only(
                bottom: widget.order.products.length * 2,
              ),
              height: widget.order.products.length * 26,
              child: Scrollbar(
                child: ListView(
                  children: widget.order.products
                      .map(
                        (product) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${product.quantity}x ${Utils.formatPrice(product.price.toDouble())}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
