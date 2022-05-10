// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/my_profile_widget.dart';
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

    return CustomScrollView(
      slivers: [
        SliverFixedExtentList(
          itemExtent: 90,
          delegate: SliverChildBuilderDelegate(
            (context, index) => Align(
              alignment: Alignment.topCenter,
              child: MyProfileWidget(),
            ),
            childCount: 1,
          ),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, //quantidade de itens por linha
            childAspectRatio: 1.2, //dimensão do item
            crossAxisSpacing: 10, //espaçamento vertical
            mainAxisSpacing: 10, //espaçamento horizontal
          ),
          delegate: SliverChildBuilderDelegate(
            //serve para restringir o nível de classes que poderão escutar o NotfierListnners da Modal
            (context, index) => ChangeNotifierProvider.value(
              value: loadedProductProvider[index],
              child: const ProductGridItemWidget(),
            ),
            childCount: loadedProductProvider.length,
          ),
        ),
      ],
    );
  }
}
