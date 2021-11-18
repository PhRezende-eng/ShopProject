import 'package:flutter/material.dart';
import 'package:shop/pages/products_overview_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
        ).copyWith(
          secondary: Colors.deepOrangeAccent,
          background: Colors.grey[700],
          surface: Colors.grey[100],
        ),
        fontFamily: 'Poppins',
      ),
      home: ProductsOverviewPage(title: 'Shop'),
      debugShowCheckedModeBanner: false,
    );
  }
}
