// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer_widget.dart';
import 'package:shop/components/empty_list_widget.dart';
import 'package:shop/components/oders_widget.dart';
import 'package:shop/providers/order_list.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<OrderListProvider>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus pedidos'),
        centerTitle: true,
      ),
      body: Center(
        child: items.isEmpty
            ? EmptyListWidget(
                'Não há pedidos',
                'Você ainda não fez nenhum pedido, vá até o shop e faça alguma compra.',
              )
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (ctx, index) => OrderWidget(
                  items[index],
                ),
              ),
      ),
      drawer: AppDrawerWidget(),
    );
  }
}
