// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer_widget.dart';
import 'package:shop/providers/product_list.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var title = ModalRoute.of(context)?.settings.arguments ?? 'Erro';
    final products = Provider.of<ProductListProvider>(context).items;

    return Scaffold(
      appBar: AppBar(
        title: Text('$title'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) => ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(products[index].imageUrl),
            ),
            title: Text(products[index].name),
            trailing: Container(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.remove),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: AppDrawerWidget(),
    );
  }
}
