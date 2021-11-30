import 'package:flutter/material.dart';
import 'package:shop/pages/product_datail_provider.dart';
import 'package:shop/pages/products_overview_page.dart';
import 'package:shop/providers/counter.dart';
import 'package:shop/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CounterProvider(
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
          AppRooutes.PRODUCT_DETAIL: (context) => const ProductExampProvider(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
