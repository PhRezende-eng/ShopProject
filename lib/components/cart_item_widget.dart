import 'package:flutter/material.dart';
import 'package:shop/models/cart_item.dart';

class CartItemWidget extends StatefulWidget {
  final CartItem cartItem;
  const CartItemWidget(
    this.cartItem, {
    Key? key,
  }) : super(key: key);

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          //server para encaixar o texto dentro do componente
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: FittedBox(
              child: Text(
                widget.cartItem.price.toStringAsFixed(2),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        title: Text(widget.cartItem.name),
        subtitle: Text(
            'Total: R\$${widget.cartItem.price * widget.cartItem.quantity}'),
        trailing: Text('${widget.cartItem.quantity}x'),
      ),
    );
  }
}
