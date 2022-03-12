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
      passwordFocusNode = FocusNode();

  TextEditingController cpfController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController();

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
        passwordFocusNode.requestFocus();
      },
      decoration: InputDecoration(
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

    TextFormField passwordInput = TextFormField(
      obscureText: true,
      controller: passwordController,
      focusNode: passwordFocusNode,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      onSaved: (password) => user.password = password!,
      onFieldSubmitted: (_) {
        passwordFocusNode.unfocus();
        cpfFocusNode.requestFocus();
      },
      decoration: InputDecoration(
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
      textInputAction: TextInputAction.done,
      onSaved: (cpf) => user.cpf = cpf!,
      onFieldSubmitted: (_) {
        cpfFocusNode.unfocus();
        makeRegister();
      },
      decoration: InputDecoration(
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
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          emailInput,
                          SizedBox(height: 16),
                          passwordInput,
                          SizedBox(height: 16),
                          cpfInput,
                          SizedBox(height: 16),
                          TextButtonWidget(
                            onPress: () => makeRegister(),
                            text: 'Criar conta',
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
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
    cpfController.dispose();
    passwordController.dispose();
    emailController.dispose();

    cpfFocusNode.dispose();
    passwordFocusNode.dispose();
    emailFocusNode.dispose();
  }
}
