// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer_widget.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/controller/product_list.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var title = ModalRoute.of(context)?.settings.arguments ?? 'Erro';
    final items = Provider.of<ProductListProvider>(context).items;

    return Scaffold(
      appBar: AppBar(
        title: Text('$title'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SizedBox(height: 16),
                ProductItemWidget(items[index]),
                SizedBox(height: 16),
                Divider()
              ],
            );
          },
        ),
      ),
      drawer: AppDrawerWidget(),
    );
  }
}
