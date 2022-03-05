// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/text_buttom_widget.dart';
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
    userRequestProvider =
        Provider.of<RequestUserProvider>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final forms = <Widget>[];

    forms.add(
      TextFormField(
        controller: emailController,
        focusNode: emailFocusNode,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
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
      ),
    );
    forms.add(returnSizedBox(8));

    forms.add(
      TextFormField(
        obscureText: true,
        controller: passwordController,
        focusNode: passwordFocusNode,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.next,
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
      ),
    );
    forms.add(returnSizedBox(8));

    forms.add(
      TextFormField(
        controller: cpfController,
        focusNode: cpfFocusNode,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
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
      ),
    );
    forms.add(returnSizedBox(16));

    forms.add(
      TextButtonWidget(
        onPress: () {
          autoValidateForm = true;
          makeRegister();
        },
        text: 'Criar conta',
      ),
    );

    return GestureDetector(
      onTap: () {
        Utils.hideKeyBoard();
      },
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
                        children: forms,
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  void makeRegister() {
    if (_key.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });

      _key.currentState!.save();

      user = UserModel(
        cpf: cpfController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      user.id = user.generateId();

      if (userProvider.canRegister(user)) {
        userRequestProvider.registerUser(user).then((response) {
          returnScaffoldMassage(response, context);
          Navigator.of(context).pop();
          setState(() {
            isLoading = false;
          });
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
          returnScaffoldMassage(error, context);
        });
      } else {
        setState(() {
          isLoading = false;
        });
        returnScaffoldMassage('Conta já cadastrado!', context);
      }
    }
  }

  Widget returnSizedBox(double height) {
    return SizedBox(
      height: height,
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      returnScaffoldMassage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return ScaffoldMessenger.of(context).showSnackBar(
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
