// ignore_for_file: unnecessary_string_interpolations

import 'package:shop/models/cart_item.dart';
import 'package:shop/models/order.dart';
import 'package:shop/models/user.dart';
import 'package:shop/services/request.dart';

class RequestOrderProvider extends RequestService {
  Future<List<OrderModel>> getOrder() async {
    final dioResponse = await getRequest('orders.json');
    Map data = dioResponse.data;
    if (dioResponse.statusMessage == 'OK') {
      List<OrderModel> orderList = [];
      for (var order in data.values) {
        orderList.add(OrderModel.fromJson(order));
      }
      // data.values.forEach((order) {
      //   orderList.add(OrderModel(
      //     id: order['id'],
      //     date: order['date'],
      //     products: order['products'],
      //     total: order['total'],
      //   ));
      //  });
      return orderList;
    } else {
      throw 'Erro ao tentar listar os pedidos.\nTente novamente mais tarde.';
    }
  }

  Future postOrder(
    OrderModel order,
    List<CartItemModel> cartItems,
    UserModel user,
  ) async {
    Map dict = order.toJson(); // metódo me retorna um map
    // Map dict = {};
    // print('$newOrder ToJson');
    // dict['id'] = order.id;
    // dict['total'] = order.total;
    // dict['products'] = cartItems;
    // dict['date'] = order.date.millisecondsSinceEpoch;
    // print('$dict Map');
    final dioResponse = await patchRequest(
      'register/${user.id}/orders.json',
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
