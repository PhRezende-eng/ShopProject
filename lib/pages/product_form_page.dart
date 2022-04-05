// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shop/components/app_drawer_widget.dart';
import 'package:shop/utils/util_functions.dart';

import '../components/confirm_buttom_widget.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.hideKeyBoard(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Editar Produto'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: autoValidate
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    child: Column(
                      children: [],
                    ),
                  ),
                ),
              ),
              TextButtonWidget(
                text: 'Confirmar edição',
                onPress: confirmEdit,
              ),
            ],
          ),
        ),
        drawer: AppDrawerWidget(),
      ),
    );
  }

  void confirmEdit() {
    autoValidate = true;
    setState(() {});
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();
    }
  }
}
