// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
              onPressed: () {},
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                showDialogToDelete(context);
              },
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
          TextButton(
            onPressed: () async {
              await productProvider.deleteItemFromList(product);
              Navigator.of(context).pop();
            },
            child: Text('Deletar'),
          )
        ],
      ),
    );
  }
}
