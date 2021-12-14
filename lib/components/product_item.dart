// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/services/requestProduct.dart';
import 'package:shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // com o listen false, ele não escutará a mudança de estado
    final product = Provider.of<Product>(context);
    final requestPRoduct = Provider.of<RequestProduct>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRooutes.PRODUCT_DETAIL,
              arguments: product,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          leading: IconButton(
            icon: Consumer<Product>(
              builder: (context, product, child) => Icon(
                product.isFavorite //caso seja true
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
              ),
            ),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () async {
              product.toggleFavorite();
              await requestPRoduct.putFavoriteRequest(product,
                  isFavorite: product.isFavorite);
            },
          ),
          title: Text(
            product.title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.surface,
            ),
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
