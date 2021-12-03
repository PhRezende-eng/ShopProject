// ignore_for_file: prefer_conditional_assignment, unused_catch_clause
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class RequestService with ChangeNotifier {
  final _domain = 'https://shop-coder-bccc3-default-rtdb.firebaseio.com';

  late Dio dio = Dio();

  String _createUrl(String endpoint, String? args) {
    if (args == null) args = '';

    if (endpoint[0] != '/') endpoint = '/$endpoint';

    if (args.isNotEmpty && args[0] != '?') args = '?$args';

    return _domain + endpoint;
  }

  Future<Response> getRequest(String endpoint,
      {String? args, int timeoutSeconds = 10}) async {
    try {
      return await dio.get(
        _createUrl(endpoint, args),
        options: Options(
          sendTimeout: timeoutSeconds * 100,
          responseType: ResponseType.json,
        ),
      );
    } on DioError catch (error) {
      throw 'Não foi possível concluir sua requisição.\n Confira a sua conexão com a internet.';
    }
  }

  Future<Response> postRequest(String endpoint,
      {String? args, int timeSeconds = 10, dynamic body}) async {
    try {
      return await dio.post(
        _createUrl(endpoint, args),
        data: body,
        options: Options(
          sendTimeout: timeSeconds * 100,
          responseType: ResponseType.json,
        ),
      );
    } on DioError catch (error) {
      throw 'Não foi possível concluir sua requisição.\n Confira a sua conexão com a internet.';
    }
  }

  Future<Response> deleteRequest(String endpoint,
      {String? args, int timeSeconds = 10, dynamic body}) async {
    try {
      return await dio.post(
        _createUrl(endpoint, args),
        data: body,
        options: Options(
          sendTimeout: timeSeconds * 100,
          responseType: ResponseType.json,
        ),
      );
    } on DioError catch (error) {
      throw 'Não foi possível concluir sua requisição.\n Confira a sua conexão com a internet.';
    }
  }

  Future<Response> putRequest(String endpoint,
      {String? args, int timeSeconds = 10, dynamic body}) async {
    try {
      return await dio.post(
        _createUrl(endpoint, args),
        data: body,
        options: Options(
          sendTimeout: timeSeconds * 100,
          responseType: ResponseType.json,
        ),
      );
    } on DioError catch (error) {
      throw 'Não foi possível concluir sua requisição.\n Confira a sua conexão com a internet.';
    }
  }
}
