// ignore_for_file: file_names, prefer_const_constructors, non_constant_identifier_names, unused_import, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer_widget.dart';
import 'package:shop/components/badge_widget.dart';
import 'package:shop/components/product_grid_widget.dart';
import 'package:shop/components/product_item_widget.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/providers/cart_map.dart';
import 'package:shop/providers/product_list.dart';
import 'package:shop/services/requestProduct.dart';
import 'package:shop/utils/app_routes.dart';

class ProductsOverviewPage extends StatefulWidget {
  final String title;
  const ProductsOverviewPage({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

enum MenuValue { favorite, all }

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  Future<void> getItems() async {
    await Provider.of<ProductListProvider>(context, listen: false).getProduct();
  }

  bool filterFavorite = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                value: MenuValue.favorite,
                child: Text('Filtrar por favorito'),
              ),
              PopupMenuItem(
                value: MenuValue.all,
                child: Text('Filtrar todos'),
              ),
            ],
            onSelected: (filterSelect) {
              setState(() {
                if (filterSelect == MenuValue.favorite) {
                  filterFavorite = true;
                } else {
                  filterFavorite = false;
                }
              });
            },
          ),
          GestureDetector(
            onTap: () => navigate(),
            child: BadgeWidget(
              value: cart.itemsCount.toString(),
              child: IconButton(
                onPressed: () => navigate(),
                icon: Icon(
                  Icons.shopping_cart,
                ),
              ),
            ),
          ),
        ],
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
            return ProductGridWidget(
              filterFavorite: filterFavorite,
            );
          },
        ),
      ),
      drawer: AppDrawerWidget(),
    );
  }

  void navigate() {
    Navigator.of(context).pushNamed(AppRooutes.CART);
    // Navigator.of(context).push(
    //     MaterialPageRoute(builder: (context) => const CartPage()));
  }
}
