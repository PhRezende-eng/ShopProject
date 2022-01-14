// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_item_widget.dart';
import 'package:shop/providers/cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final items = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text('Total'),
                  ),
                  SizedBox(width: 5),
                  Chip(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    label: Text(
                      'R\$${cart.totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.white,
                        // Theme.of(context).primaryTextTheme.headline6?.color,
                      ),
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    child: Text('COMPRAR'),
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, i) {
                return CartItemWidget(items[i]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
