// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/providers/cart_map.dart';
import 'package:shop/utils/util_functions.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel cartItem;
  const CartItemWidget(
    this.cartItem, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String total =
        Utils.formatPrice((cartItem.price * cartItem.quantity).toDouble());
    String price = Utils.formatPriceWithoutR$(cartItem.price.toDouble());

    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        padding: EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        margin: EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 32,
        ),
      ),
      confirmDismiss: (_) async {
        var shouldRemoveProduct = await showConfirmDialog(context);
        if (shouldRemoveProduct == 'remove') {
          Provider.of<CartProvider>(context, listen: false)
              .removeItem(cartItem.productId);
        }
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
                  price,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          title: Text(cartItem.name),
          subtitle: Text('Total: $total'),
          trailing: Text('${cartItem.quantity}x'),
        ),
      ),
    );
  }

  Future<String?> showConfirmDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remover Produto'),
        content: Text('Você remover este produto do seu pedido?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop('cancel');
            },
            child: Text(
              'Cancelar',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondaryVariant,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop('remove');
            },
            child: Text('Remover'),
          ),
        ],
      ),
    );
  }
}
