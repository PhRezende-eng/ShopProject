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

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: RequestProductProvider()),
        ChangeNotifierProvider.value(value: RequestOrderProvider()),
        ChangeNotifierProvider.value(value: RequestUserProvider()),
        ChangeNotifierProvider.value(value: ProductListProvider()),
        ChangeNotifierProvider.value(value: OrderListProvider()),
        ChangeNotifierProvider.value(value: UserProvider()),
        ChangeNotifierProvider.value(value: CartProvider()),
      ],
      child: MaterialApp(
        title: 'Shop',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.green,
          ).copyWith(
            primary: Colors.purple[400],
            secondary: Colors.deepOrangeAccent,
            background: Colors.orange[200],
            primaryVariant: Colors.grey[100],
            secondaryVariant: Colors.grey[400],
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
      ),
    );
  }
}
