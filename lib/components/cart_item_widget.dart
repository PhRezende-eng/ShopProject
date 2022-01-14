// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/providers/cart.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  const CartItemWidget(
    this.cartItem, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 32,
        ),
        padding: EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        margin: EdgeInsets.fromLTRB(12, 8, 12, 8),
      ),
      onDismissed: (_) {
        Provider.of<CartProvider>(context, listen: false)
            .removeItem(cartItem.productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: ListTile(
          //serve para encaixar o texto dentro do componente
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: EdgeInsets.all(3),
              child: FittedBox(
                child: Text(
                  cartItem.price.toStringAsFixed(2),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          title: Text(cartItem.name),
          subtitle: Text('Total: R\$${cartItem.price * cartItem.quantity}'),
          trailing: Text('${cartItem.quantity}x'),
        ),
      ),
    );
  }
}
