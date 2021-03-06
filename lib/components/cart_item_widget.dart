// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/dialog_confirm_button_widget.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/controller/cart_map.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel cartItem;
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
        bool shouldRemoveProduct = await showConfirmDialog(context) ?? false;
        if (shouldRemoveProduct) {
          Provider.of<CartProvider>(context, listen: false)
              .removeItem(cartItem.productId);
        }
        return null;
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
                  cartItem.productPrice(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          title: Text(cartItem.name),
          subtitle: Text('Total: ${cartItem.totalPrice()}'),
          trailing: Text('${cartItem.quantity}x'),
        ),
      ),
    );
  }

  Future<bool?> showConfirmDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remover Produto'),
        content: Text('Voc?? remover este produto do seu pedido?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancelar',
              // style: TextStyle(
              //   color: Theme.of(context).colorScheme.secondaryContainer,
              // ),
            ),
          ),
          ConfirmDialogButtomWidget(
            color: Theme.of(context).colorScheme.copyWith().error,
            onPress: () => Navigator.of(context).pop(true),
            text: 'Remover',
          ),
        ],
      ),
    );
  }
}
