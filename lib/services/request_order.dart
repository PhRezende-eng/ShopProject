// ignore_for_file: unnecessary_string_interpolations

import 'package:shop/models/order.dart';
import 'package:shop/providers/cart_map.dart';
import 'package:shop/services/request.dart';

class RequestOrderProvider extends RequestService {
  Future<List<OrderModel>> getOrder() async {
    final dioResponse = await getRequest('orders.json');
    final data = dioResponse.data;
    if (dioResponse.statusMessage == 'OK') {
      var orderList = <OrderModel>[];
      for (var order in data.values) {
        orderList.add(OrderModel.fromJson(order));
      }
      return orderList;
    } else {
      throw 'Erro ao tentar listar os pedidos.\nTente novamente mais tarde.';
    }
  }

  Future postOrder(OrderModel order, CartProvider cart) async {
    var dict = {};

    dict['id'] = order.id;
    dict['date'] = order.date.millisecondsSinceEpoch;
    dict['products'] = cart.items.values.toList();
    dict['total'] = order.total;

    final dioResponse = await postRequest(
      'orders.json',
      body: dict,
    );
    if (dioResponse.statusMessage == 'OK') {
      return 'Pedido feito com sucesso!';
    } else {
      throw 'Erro ao tentar salvar um pedido.\nTente novamente mais tarde.';
    }
  }

  Future finishOrder() async {}
}