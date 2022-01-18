import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/order.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/oders_page.dart';
import 'package:shop/providers/cart_map.dart';
import 'package:shop/providers/order_list.dart';
import 'package:shop/providers/product_list.dart';
import 'package:shop/pages/product_datail_page.dart';
import 'package:shop/pages/products_overview_page.dart';
import 'package:shop/services/requestProduct.dart';
import 'package:shop/utils/app_routes.dart';

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
        ChangeNotifierProvider.value(value: ProductListProvider()),
        ChangeNotifierProvider.value(value: OrderListProvider()),
        ChangeNotifierProvider.value(value: CartProvider()),
      ],
      child: MaterialApp(
        title: 'Shop',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.purple,
          ).copyWith(
            primary: Colors.purple,
            secondary: Colors.deepOrangeAccent,
            background: Colors.orange[200],
            surface: Colors.grey[100], //cores de strings
          ),
          fontFamily: 'Poppins',
        ),
        // Exemplo de sem ou com navegação por rotas
        home: const ProductsOverviewPage(title: 'Shop'),
        initialRoute: AppRooutes.Home,
        //
        routes: {
          AppRooutes.PRODUCT_DETAIL: (context) => const ProductDetailPage(),
          AppRooutes.CART: (context) => const CartPage(),
          AppRooutes.ORDERS: (context) => const OrdersPage(),
          AppRooutes.Home: (context) =>
              const ProductsOverviewPage(title: 'Shop'),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
