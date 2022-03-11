// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    user = UserModel();
    userRequestProvider =
        Provider.of<RequestUserProvider>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextFormField emailInput = TextFormField(
      focusNode: emailFocusNode,
      controller: emailController,
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
        } else if (email == '') {
          return 'Você presicar colocar um email.';
        }
        return null;
      },
    );

    TextFormField passwordInput = TextFormField(
      obscureText: true,
      focusNode: passwordFocusNode,
      controller: passwordController,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.go,
      onSaved: (password) => user.password = password!,
      onFieldSubmitted: (_) => makeLoginIfCan(),
      decoration: InputDecoration(
        labelText: 'Senha',
        hintText: '*******',
      ),
      validator: (password) {
        if (password!.length < 6) {
          return 'A está muito curta.';
        } else if (password == '') {
          return 'Você presicar colocar uma senha.';
        }
        return null;
      },
    );

    return GestureDetector(
      onTap: () {
        Utils.hideKeyBoard();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Padding(
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
                      children: [
                        emailInput,
                        SizedBox(height: 16),
                        passwordInput,
                        SizedBox(height: 16),
                        TextButtonWidget(
                          onPress: () => makeLoginIfCan(),
                          text: 'Acessar conta',
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Future makeLoginIfCan() async {
    validate = true;
    setState(() {});
    if (_key.currentState?.validate() ?? false) {
      isLoading = true;
      setState(() {});

      _key.currentState!.save();

      final stringConditionToLogin = userProvider.canLogin(user);
      if (stringConditionToLogin == 'Conta logada com sucesso!') {
        try {
          final response = await userRequestProvider.loginUser(user);
          returnScaffoldMassage(response, context);
          setInMemory(emailController.text);
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        } catch (error) {
          isLoading = false;
          setState(() {});
          returnScaffoldMassage(error.toString(), context);
        }
      } else {
        isLoading = false;
        setState(() {});
        returnScaffoldMassage(stringConditionToLogin, context);
      }
    }
  }

  void setInMemory(String email) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('_user', email);
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

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }
}
