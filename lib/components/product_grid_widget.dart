// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_grid_item_widget.dart';
import 'package:shop/controller/product_list.dart';

class ProductGridWidget extends StatelessWidget {
  final bool filterFavorite;
  const ProductGridWidget({required this.filterFavorite, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<ProductListProvider>(context);
    final loadedProductProvider =
        filterFavorite ? productList.favoriteItem : productList.items;

    return GridView.builder(
      itemCount: loadedProductProvider.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        //quando há um um Provider já criado, no caso tem na main.
        value: loadedProductProvider[index],
        child: const ProductGridItemWidget(),
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
