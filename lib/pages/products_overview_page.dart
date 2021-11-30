// ignore_for_file: file_names, prefer_const_constructors, non_constant_identifier_names, unused_import, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/services/requestProduct.dart';

class ProductsOverviewPage extends StatefulWidget {
  final String title;
  const ProductsOverviewPage({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  List<Product> loadedProducts = [];
  late RequestProduct requestProduct;

  Future<void> getItems() async {
    loadedProducts = await RequestProduct().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    List<Product> loadedProductProvider =
        Provider.of<ProductList>(context).items;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
          future: getItems(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
            return GridView.builder(
              itemCount: loadedProducts.length,
              itemBuilder: (context, index) => Column(
                children: [
                  Expanded(
                    child: ProductItem(
                      product: loadedProducts[index],
                    ),
                  ),
                ],
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //quantidade de itens por linha
                childAspectRatio: 1.2, //dimensãao do item
                crossAxisSpacing: 10, //espaçamento vertical
                mainAxisSpacing: 10, //espaçamento horizontal
              ),
            );
          },
        ),
      ),
    );
  }
}
