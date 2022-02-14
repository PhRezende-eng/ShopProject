import 'package:flutter/material.dart';
import 'package:shop/controller/counter.dart';

class ProductExampProvider extends StatefulWidget {
  const ProductExampProvider({Key? key}) : super(key: key);

  @override
  _ProductExampProviderState createState() => _ProductExampProviderState();
}

class _ProductExampProviderState extends State<ProductExampProvider> {
  @override
  Widget build(BuildContext context) {
    final provider = CounterProvider.of(context)?.state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemplo Providers'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(provider?.value.toString() ?? '0'),
            IconButton(
              onPressed: () {
                setState(() {
                  provider?.inc();
                });
              },
              icon: const Icon(
                Icons.add,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  provider?.dec();
                });
              },
              icon: const Icon(
                Icons.remove,
              ),
            )
          ],
        ),
      ),
    );
  }
}
