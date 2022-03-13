// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/dialog_confirm_button_widget.dart';
import 'package:shop/controller/product_list.dart';
import 'package:shop/models/product.dart';

class ProductItemWidget extends StatelessWidget {
  final ProductModal product;
  const ProductItemWidget({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              color: Theme.of(context).colorScheme.copyWith().primary,
              onPressed: () {},
              icon: Icon(Icons.edit),
            ),
            IconButton(
              color: Theme.of(context).colorScheme.copyWith().error,
              onPressed: () => showDialogToDelete(context),
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }

  Future showDialogToDelete(BuildContext context) async {
    final productProvider =
        Provider.of<ProductListProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Deletar produto'),
        content: Text('Você deseja deletar produto?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          ),
          ConfirmDialogButtomWidget(
            color: Theme.of(context).colorScheme.copyWith().error,
            onPress: () async {
              await productProvider.deleteItemFromList(product);
              Navigator.of(context).pop();
            },
            text: 'Deletar',
          ),
        ],
      ),
    );
  }
}
