// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/controller/user.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/profile/widgets/login_widget.dart';
import 'package:shop/pages/oders_page.dart';
import 'package:shop/pages/product_page.dart';
import 'package:shop/pages/profile/widgets/register_widget.dart';
import 'package:shop/controller/cart_map.dart';
import 'package:shop/controller/order_list.dart';
import 'package:shop/controller/product_list.dart';
import 'package:shop/pages/product_datail_page.dart';
import 'package:shop/pages/products_overview_page.dart';
import 'package:shop/services/request_order.dart';
import 'package:shop/services/request_product.dart';
import 'package:shop/services/request_user.dart';
import 'package:shop/utils/app_routes.dart';

import 'pages/profile/profile_page.dart';

void main() async {
  final productProvider = RequestProductProvider();
  final orderProvider = RequestOrderProvider();
  final userRequestProvider = RequestUserProvider();
  final productListProvider = ProductListProvider();
  final orderListProvider = OrderListProvider();
  final userProvider = UserProvider();
  final cartProvider = CartProvider();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: userProvider),
        ChangeNotifierProvider.value(value: productProvider),
        ChangeNotifierProvider.value(value: orderProvider),
        ChangeNotifierProvider.value(value: userRequestProvider),
        ChangeNotifierProvider.value(value: productListProvider),
        ChangeNotifierProvider.value(value: orderListProvider),
        ChangeNotifierProvider.value(value: cartProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getUser(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
        ).copyWith(
          primary: Colors.purple[400],
          secondary: Colors.deepOrangeAccent,
          background: Colors.orange[200],
          primaryContainer: Colors.grey[100],
          secondaryContainer: Colors.grey[400],
        ),
        fontFamily: 'Poppins',
      ),
      // Exemplo de sem ou com navegação por rotas
      // home: const ProductsOverviewPage(title: 'Shop'),
      // initialRoute: AppRooutes.Home,
      //
      routes: {
        AppRooutes.PRODUCT_DETAIL: (context) => ProductDetailPage(),
        AppRooutes.PRODUCT_PAGE: (context) => ProductPage(),
        AppRooutes.REGISTER: (context) => RegisterWidget(),
        AppRooutes.PROFILE: (context) => ProfilePage(),
        AppRooutes.LOGIN: (context) => LoginWidget(),
        AppRooutes.ORDERS: (context) => OrdersPage(),
        AppRooutes.Home: (context) => ProductsOverviewPage(title: 'Shop'),
        AppRooutes.CART: (context) => CartPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }

  Future getUser(BuildContext context) async {
    await Provider.of<UserProvider>(context, listen: false)
        .getUsersFromDB(context);
  }
}
