import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/util_functions.dart';

import '../components/confirm_buttom_widget.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  final formData = <String, Object>{};
  bool autoValidate = false;
  bool initValues = false;

  ProductModal? product;

  final controllerName = TextEditingController(),
      controllerPrice = TextEditingController(),
      controllerDescription = TextEditingController(),
      controllerImage = TextEditingController();

  final focusName = FocusNode(),
      focusPrice = FocusNode(),
      focusDescription = FocusNode(),
      focusImage = FocusNode();

  @override
  void initState() {
    focusImage.addListener(updateUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    product = ModalRoute.of(context)?.settings.arguments as ProductModal?;

    if (product != null && !initValues) {
      controllerName.text = product!.name;
      controllerName.selection =
          TextSelection.collapsed(offset: controllerName.text.length);

      controllerPrice.text = product!.price.toString();
      controllerPrice.selection =
          TextSelection.collapsed(offset: controllerPrice.text.length);

      controllerDescription.text = product!.description;
      controllerDescription.selection =
          TextSelection.collapsed(offset: controllerDescription.text.length);

      controllerImage.text = product!.imageUrl;
      controllerImage.selection =
          TextSelection.collapsed(offset: controllerImage.text.length);

      formData['id'] = product!.id;

      initValues = true;
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    focusName.dispose();
    controllerName.dispose();
    focusPrice.dispose();
    controllerPrice.dispose();
    focusDescription.dispose();
    controllerDescription.dispose();
    focusImage.removeListener(updateUrl);
    focusImage.dispose();
    controllerImage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final name = TextFormField(
      focusNode: focusName,
      controller: controllerName,
      textInputAction: TextInputAction.next,
      onSaved: (name) => formData['name'] = name ?? '',
      validator: (name) {
        name = name ?? '';
        //trim remove blank space
        if (name.trim() == '') {
          return 'Você precisa preencher o nome';
        }
        return null;
      },
      onFieldSubmitted: (text) {
        FocusScope.of(context).unfocus();
        FocusScope.of(context).requestFocus(focusPrice);
      },
      decoration: const InputDecoration(
        labelText: 'Nome',
        hintText: 'Fone de ouvido Razer',
        border: OutlineInputBorder(),
      ),
    );

    final price = TextFormField(
      focusNode: focusPrice,
      controller: controllerPrice,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputAction: TextInputAction.next,
      onSaved: (price) => formData['price'] =
          num.parse(price == '' || price == null ? '0' : price),
      validator: (price) {
        price = price ?? '';
        if (price.trim() == '') {
          return 'Você precisa preencher o preço';
        } else if (!price.trim().contains('.')) {
          return 'Preencha com ponto flutuante usando "."';
        }
        return null;
      },
      onFieldSubmitted: (text) {
        focusPrice.unfocus();
        focusDescription.requestFocus();
      },
      decoration: const InputDecoration(
        labelText: 'Preço',
        hintText: '325.00',
        border: OutlineInputBorder(),
      ),
    );

    final description = TextFormField(
      focusNode: focusDescription,
      controller: controllerDescription,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      maxLines: 3,
      onSaved: (description) =>
          formData['description'] = description?.trim() ?? '',
      validator: (description) {
        description = description ?? '';
        if (description.trim() == '') {
          return 'Você precisa preencher a descrição';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'Descrição',
        hintText: 'Fone de ouvido Razer com Led, 7.1 surround real',
        border: OutlineInputBorder(),
      ),
    );

    final urlImage = TextFormField(
      focusNode: focusImage,
      controller: controllerImage,
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.go,
      onSaved: (urlImage) => formData['imageUrl'] = urlImage ?? '',
      validator: (urlImage) {
        urlImage = urlImage ?? '';
        if (!urlImage.trim().contains('http') ||
            !urlImage.trim().contains('/')) {
          return 'Preencha uma url válida';
        }
        return null;
      },
      onFieldSubmitted: (_) {
        focusImage.unfocus();
        submittedForm();
      },
      decoration: const InputDecoration(
        labelText: 'Link da imagem',
        hintText:
            'https://storage.googleapis.com/cms-storage-bucket/70760bf1e88b184bb1bc.png',
        border: OutlineInputBorder(),
      ),
    );

    return GestureDetector(
      onTap: Utils.hideKeyBoard,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            product == null ? 'Adicionar produto' : 'Edição de produto',
          ),
          actions: [
            IconButton(
              onPressed: submittedForm,
              icon: const Icon(Icons.save),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  autovalidateMode: autoValidate
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  child: ListView(
                    children: [
                      const SizedBox(height: 8),
                      name,
                      const SizedBox(height: 16),
                      price,
                      const SizedBox(height: 16),
                      description,
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(child: urlImage),
                          const SizedBox(width: 8),
                          Container(
                            height: 120,
                            width: 120,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: controllerImage.text.isEmpty
                                ? const Text('Informe a Url')
                                : Image(
                                    image: NetworkImage(
                                      controllerImage.text,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              if (Utils.hideButtonWithKeyBoard(context))
                TextButtonWidget(
                  text:
                      product == null ? 'Confirmar adição' : 'Confirmar edição',
                  onPress: submittedForm,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void updateUrl() {
    if (!focusImage.hasFocus) {
      setState(() {});
    }
  }

  void submittedForm() {
    autoValidate = true;
    setState(() {});
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();

      // final newProduct = ProductModal.fromJson(formData);
    }
  }
}
