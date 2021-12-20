import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/product_list.dart';
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
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => ProductList()),
        ChangeNotifierProvider(create: (_) => RequestProduct())
      ],
      child: MaterialApp(
        title: 'Shop',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.purple,
          ).copyWith(
            secondary: Colors.deepOrangeAccent,
            background: Colors.orange[200],
            surface: Colors.grey[100], //cores de strings
          ),
          fontFamily: 'Poppins',
        ),
        home: const ProductsOverviewPage(title: 'Shop'),
        routes: {
          AppRooutes.PRODUCT_DETAIL: (context) => const ProductDetailPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
