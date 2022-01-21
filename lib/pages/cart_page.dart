// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_item_widget.dart';
import 'package:shop/components/empty_list_widget.dart';
import 'package:shop/providers/cart_map.dart';
import 'package:shop/providers/order_list.dart';
import 'package:shop/utils/util_functions.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CartProvider cart;
  late String total;
  late List items;
  late Size size;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cart = Provider.of<CartProvider>(context);
    total = Utils.formatPrice(cart.totalPrice);
    items = cart.items.values.toList();
    size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
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
                  //Container com borda arredonda
                  Chip(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    label: Text(
                      '$total',
                      style: TextStyle(
                        color: Colors.white,
                        // Theme.of(context).primaryTextTheme.headline6?.color,
                      ),
                    ),
                  ),
                  Spacer(),
                  if (cart.totalPrice > 0)
                    TextButton(
                      child: Text('COMPRAR'),
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      onPressed: () {
                        Provider.of<OrderListProvider>(context, listen: false)
                            .addOrder(cart);
                        cart.clearItems();
                      },
                    ),
                ],
              ),
            ),
          ),
          cart.items.isEmpty
              ? Padding(
                  padding: EdgeInsets.only(top: size.height * 0.3),
                  child: EmptyListWidget(
                    'Carrinho vazio',
                    'Você ainda não adicionou nenhum produto no carrinho, vá até o shop e escolha algum produto.',
                  ),
                )
              : Expanded(
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
