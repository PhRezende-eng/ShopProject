// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/controller/cart_map.dart';
import 'package:shop/services/request_product.dart';
import 'package:shop/utils/app_routes.dart';

class ProductGridItemWidget extends StatelessWidget {
  const ProductGridItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // com o listen false, ele não escutará a mudança de estado
    final requestProduct = Provider.of<RequestProductProvider>(context);
    final product = Provider.of<ProductModal>(context);
    final cart = Provider.of<CartProvider>(context);
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
          child: Hero(
            tag: product.id,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          leading: IconButton(
            icon: Consumer<ProductModal>(
              //O consumer tem a mesma função do Provider.of<Product>(context )
              builder: (context, product, child) => Icon(
                product.isFavorite //caso seja true, ele mudará pois o estará escutando pela provider
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
              ),
            ),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () async {
              product.toggleFavorite();
              await requestProduct.patchFavoriteRequest(product,
                  isFavorite: product.isFavorite);
            },
          ),
          title: Text(
            product.name,
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
            onPressed: () {
              cart.addItem(product);
              callSnackBar(context);
            },
          ),
        ),
      ),
    );
  }

  void callSnackBar(BuildContext context) {
    final product = Provider.of<ProductModal>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);
    //Pecorre a arvore de components e procura o scaffold raiza que é o da tela inicial, pois toda tela há um scaffold
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Adicionado'),
        duration: Duration(seconds: 2),
        action: SnackBarAction(
            label: 'DESFAZER',
            onPressed: () {
              cart.removeLastAddItem(
                cart.valuesList()[cart.getLength - 1],
                product.id,
              );
            }),
      ),
    );
  }
}
