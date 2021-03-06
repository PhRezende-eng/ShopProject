// ignore_for_file: file_names, prefer_const_constructors, non_constant_identifier_names, unused_import, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer_widget.dart';
import 'package:shop/components/badge_widget.dart';
import 'package:shop/components/product_grid_widget.dart';
import 'package:shop/components/product_grid_item_widget.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/controller/cart_map.dart';
import 'package:shop/controller/product_list.dart';
import 'package:shop/controller/user.dart';
import 'package:shop/services/request_product.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/my_profile_widget.dart';

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
  late ProductListProvider listProvider;
  late CartProvider cart;
  bool filterFavorite = false;
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    listProvider = Provider.of<ProductListProvider>(context, listen: false);
    cart = Provider.of<CartProvider>(context);
    getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              value: cart.itemCountCart.toString(),
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
      body: RefreshIndicator(
        onRefresh: () async {
          listProvider.clearListItems();
          setState(() {
            isLoading = true;
          });
          await getItems();
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    // MyProfileWidget(),
                    // SizedBox(height: 8),
                    // Divider(height: 0),
                    Expanded(
                      child: ProductGridWidget(
                        filterFavorite: filterFavorite,
                      ),
                    ),
                  ],
                ),
        ),
      ),
      drawer: AppDrawerWidget(),
    );
  }

  Future getItems() async {
    await listProvider.getProduct();
    setState(() {
      isLoading = false;
    });
  }

  void navigate() {
    Navigator.of(context).pushNamed(AppRooutes.CART);
    // Navigator.of(context).push(
    //     MaterialPageRoute(builder: (context) => const CartPage()));
  }
}
