// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_item_widget.dart';
import 'package:shop/components/empty_list_widget.dart';
import 'package:shop/controller/cart_map.dart';
import 'package:shop/controller/order_list.dart';
import 'package:shop/models/cart_item.dart';

import 'package:shop/services/request_order.dart';
import 'package:shop/utils/util_functions.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late OrderListProvider order;
  late CartProvider cart;
  late String total;
  late List<CartItemModel> cartItems;
  late Size size;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    order = Provider.of<OrderListProvider>(context);
    cart = Provider.of<CartProvider>(context);
    size = MediaQuery.of(context).size;
    total = Utils.formatPrice(cart.totalPrice);
    cartItems = cart.valuesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
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
                        order.addOrder(cart);
                        order.saveOrder(context, cartItems);
                        cart.clearItems();
                      },
                    ),
                ],
              ),
            ),
          ),
          cart.items.isEmpty
              ? Padding(
                  padding: EdgeInsets.only(top: size.height * 0.25),
                  child: EmptyListWidget(
                    'Carrinho vazio',
                    'Você ainda não adicionou nenhum produto no carrinho, vá até o shop e escolha algum produto.',
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (ctx, i) {
                      return CartItemWidget(cartItems[i]);
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
