// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/models/product_list.dart';

class ProductGrid extends StatelessWidget {
  final bool filterFavorite;
  const ProductGrid({required this.filterFavorite, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<ProductList>(context);
    final loadedProductProvider =
        filterFavorite ? productList.favoriteItem : productList.items;

    return GridView.builder(
      itemCount: loadedProductProvider.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        //quando há um um Provider já criado, no caso tem na main.
        value: loadedProductProvider[index],
        child: const ProductItem(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //quantidade de itens por linha
        childAspectRatio: 1.2, //dimensão do item
        crossAxisSpacing: 10, //espaçamento vertical
        mainAxisSpacing: 10, //espaçamento horizontal
      ),
    );
  }
}
