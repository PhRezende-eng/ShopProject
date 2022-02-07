// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop/components/app_drawer_widget.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var title = ModalRoute.of(context)?.settings.arguments ?? 'Erro';
    return Scaffold(
      appBar: AppBar(
        title: Text('$title'),
      ),
      body: Container(),
      drawer: AppDrawerWidget(),
    );
  }
}
