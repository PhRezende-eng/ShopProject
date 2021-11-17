// ignore_for_file: file_names, prefer_const_constructors, non_constant_identifier_names, unused_import, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductsOverviewPage extends StatelessWidget {
  final String title;
  ProductsOverviewPage({
    required this.title,
    Key? key,
  }) : super(key: key);

  final List<Product> loadedProducts = dummyProducts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: loadedProducts.length,
          itemBuilder: (context, index) => Column(
            children: [
              Text(loadedProducts[index].title),
              Text(loadedProducts[index].id),
              Text(loadedProducts[index].description),
            ],
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, //quantidade de itens por linha
            childAspectRatio: 2 / 3, //dimensãao do item
            crossAxisSpacing: 10, //espaçamento vertical
            mainAxisSpacing: 10, //espaçamento horizontal
          ),
        ),
      ),
    );
  }
}
