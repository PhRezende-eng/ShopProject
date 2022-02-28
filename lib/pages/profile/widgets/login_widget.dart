// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/text_buttom_widget.dart';
import 'package:shop/models/user.dart';
import 'package:shop/controller/user.dart';
import 'package:shop/services/request_user.dart';
import 'package:shop/utils/util_functions.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late RequestUserProvider userRequestProvider;
  late UserProvider userProvider;
  late UserModel user;
  final _key = GlobalKey<FormState>();
  late TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();
  late FocusNode emailFocusNode = FocusNode(), passwordFocusNode = FocusNode();

  bool isLoading = false;
  bool validate = false;

  @override
  void initState() {
    userRequestProvider =
        Provider.of<RequestUserProvider>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var forms = <Widget>[];

    forms.add(
      TextFormField(
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'email@exemplo.com',
        ),
        obscureText: false,
        focusNode: emailFocusNode,
        controller: emailController,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          emailFocusNode.unfocus();
          passwordFocusNode.requestFocus();
        },
        validator: (email) {
          if (!email!.contains('@') || !email.contains('.com')) {
            return 'Email inválido.';
          } else if (email == '') {
            return 'Você presicar colocar um email.';
          }
          return null;
        },
      ),
    );

    forms.add(returnSizedBox(8));

    forms.add(
      TextFormField(
        decoration: InputDecoration(
          labelText: 'Senha',
          hintText: '*******',
        ),
        obscureText: true,
        focusNode: passwordFocusNode,
        controller: passwordController,
        textInputAction: TextInputAction.go,
        onFieldSubmitted: (_) => makeLoginIfCan(),
        validator: (password) {
          if (password!.length < 6) {
            return 'A está muito curta.';
          } else if (password == '') {
            return 'Você presicar colocar uma senha.';
          }
          return null;
        },
      ),
    );

    forms.add(returnSizedBox(16));

    forms.add(
      TextButtonWidget(
        onPress: () {
          validate = true;

          makeLoginIfCan();
        },
        text: 'Acessar conta',
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: GestureDetector(
        onTap: () {
          Utils.hideKeyBoard();
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: isLoading
                ? CircularProgressIndicator()
                : Form(
                    key: _key,
                    autovalidateMode: validate
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: forms,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  void makeLoginIfCan() {
    if (_key.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });

      _key.currentState!.save();

      user = UserModel(
        email: emailController.text,
        password: passwordController.text,
      );

      if (userProvider.canLogin(user)) {
        userRequestProvider.loginUser(user).then((response) {
          setState(() {
            isLoading = false;
          });
          returnScaffoldMassage(response, context);
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
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
        returnScaffoldMassage('Conta não registrada', context);
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
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }
}
