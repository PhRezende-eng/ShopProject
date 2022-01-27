// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer_widget.dart';
import 'package:shop/components/empty_list_widget.dart';
import 'package:shop/components/oders_widget.dart';
import 'package:shop/models/order.dart';
import 'package:shop/services/request_order.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  var items = <OrderModel>[];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getItems();
  }

  @override
  Widget build(BuildContext context) {
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

  Future getItems() async {
    items = await Provider.of<RequestOrderProvider>(context).getOrder();
  }
}
