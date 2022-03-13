// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/confirm_buttom_widget.dart';
import 'package:shop/controller/user.dart';
import 'package:shop/models/user.dart';
import 'package:shop/services/request_user.dart';
import 'package:shop/utils/util_functions.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  _RegideterPageState createState() => _RegideterPageState();
}

class _RegideterPageState extends State<RegisterWidget> {
  late RequestUserProvider userRequestProvider;
  late UserProvider userProvider;
  late UserModel user;
  final _key = GlobalKey<FormState>();

  FocusNode cpfFocusNode = FocusNode(),
      emailFocusNode = FocusNode(),
      passwordFocusNode = FocusNode(),
      nameFocusNode = FocusNode(),
      lastNameFocusNode = FocusNode(),
      urlPhotoFocusNode = FocusNode(),
      numberFocusNode = FocusNode();

  TextEditingController cpfController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController(),
      nameController = TextEditingController(),
      lastNameController = TextEditingController(),
      urlPhotoController = TextEditingController(),
      numberController = TextEditingController();

  bool autoValidateForm = false;
  bool isLoading = false;

  @override
  void initState() {
    user = UserModel();
    userRequestProvider =
        Provider.of<RequestUserProvider>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextFormField emailInput = TextFormField(
      controller: emailController,
      focusNode: emailFocusNode,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onSaved: (email) => user.email = email!,
      onFieldSubmitted: (_) {
        emailFocusNode.unfocus();
        numberFocusNode.requestFocus();
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Email',
        hintText: 'email@exemplo.com',
      ),
      validator: (email) {
        if (!email!.contains('@') || !email.contains('.com')) {
          return 'Email inválido.';
        } else {
          return null;
        }
      },
    );

    TextFormField nameInput = TextFormField(
      controller: nameController,
      focusNode: nameFocusNode,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (name) => user.name = name!,
      onFieldSubmitted: (_) {
        nameFocusNode.unfocus();
        lastNameFocusNode.requestFocus();
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Nome',
        hintText: 'João',
      ),
      validator: (name) {
        return null;
      },
    );

    TextFormField lastNameInput = TextFormField(
      controller: lastNameController,
      focusNode: lastNameFocusNode,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      onSaved: (lastName) => user.lastName = lastName!,
      onFieldSubmitted: (_) {
        lastNameFocusNode.unfocus();
        urlPhotoFocusNode.requestFocus();
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Sobrenome',
        hintText: 'Pedro',
      ),
      validator: (lastName) {
        return null;
      },
    );

    TextFormField urlPhotoInput = TextFormField(
      controller: urlPhotoController,
      focusNode: urlPhotoFocusNode,
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.next,
      onSaved: (urlPhoto) => user.urlPhoto = urlPhoto!,
      onFieldSubmitted: (_) {
        urlPhotoFocusNode.unfocus();
        passwordFocusNode.requestFocus();
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Foto de Perfil',
        hintText:
            'https://storage.googleapis.com/cms-storage-bucket/70760bf1e88b184bb1bc.png',
      ),
      validator: (urlPhoto) {
        return null;
      },
    );

    TextFormField numberInput = TextFormField(
      controller: numberController,
      focusNode: numberFocusNode,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onSaved: (number) => user.number = number!,
      onFieldSubmitted: (_) {
        numberFocusNode.unfocus();
        cpfFocusNode.requestFocus();
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Número',
        hintText: '61-982347819',
      ),
      validator: (number) {
        if (number!.length < 11 && number.length > 12) {
          return 'Quantidade de números errada!';
        }
        return null;
      },
    );

    TextFormField passwordInput = TextFormField(
      obscureText: true,
      controller: passwordController,
      focusNode: passwordFocusNode,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.go,
      onSaved: (password) => user.password = password!,
      onFieldSubmitted: (_) {
        passwordFocusNode.unfocus();
        makeRegister();
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Senha',
        hintText: '*******',
      ),
      validator: (password) {
        if (password!.length < 6) {
          return 'A está muito curta.';
        } else {
          return null;
        }
      },
    );

    TextFormField cpfInput = TextFormField(
      controller: cpfController,
      focusNode: cpfFocusNode,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onSaved: (cpf) => user.cpf = cpf!,
      onFieldSubmitted: (_) {
        cpfFocusNode.unfocus();
        nameFocusNode.requestFocus();
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'CPF',
        hintText: '123.456.789-01',
      ),
      validator: (cpf) {
        if (cpf!.length != 14) {
          return 'CPF inválido.';
        } else {
          return null;
        }
      },
    );

    return GestureDetector(
      onTap: () => Utils.hideKeyBoard(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Registre-se'),
        ),
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : Padding(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _key,
                    autovalidateMode: autoValidateForm
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 8),
                                emailInput,
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: numberInput,
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: cpfInput,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: nameInput,
                                      flex: 3,
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: lastNameInput,
                                      flex: 4,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                urlPhotoInput,
                                SizedBox(height: 16),
                                passwordInput,
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextButtonWidget(
                          onPress: () => makeRegister(),
                          text: 'Criar conta',
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Future makeRegister() async {
    autoValidateForm = true;
    setState(() {});
    if (_key.currentState?.validate() ?? false) {
      isLoading = true;
      setState(() {});

      _key.currentState!.save();

      user.id = user.generateId();

      if (userProvider.canRegister(user)) {
        try {
          final response = await userRequestProvider.registerUser(user);
          returnScaffoldMassage(response, context);
          Navigator.of(context).pop();
        } catch (error) {
          isLoading = false;
          setState(() {});
          returnScaffoldMassage(error.toString(), context);
        }
      } else {
        isLoading = false;
        setState(() {});
        returnScaffoldMassage('Conta já cadastrada!', context);
      }
    }
  }

  void returnScaffoldMassage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    cpfController.dispose();
    nameController.dispose();
    lastNameController.dispose();
    urlPhotoController.dispose();
    numberController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    cpfFocusNode.dispose();
    nameFocusNode.dispose();
    lastNameFocusNode.dispose();
    urlPhotoFocusNode.dispose();
    numberFocusNode.dispose();
  }
}
