// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer_widget.dart';
import 'package:shop/components/confirm_button_widget.dart';
import 'package:shop/services/request_user.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  late RequestUserProvider userProvider;
  late Map user;
  final _key = GlobalKey<FormState>();
  late TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();

  bool isLoading = false;
  bool validate = false;

  @override
  void initState() {
    userProvider = Provider.of<RequestUserProvider>(context, listen: false);
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
        controller: emailController,
        validator: (email) {
          if (!email!.contains('@') && !email.contains('.com')) {
            return 'Email inválido.';
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
        controller: passwordController,
        validator: (password) {
          if (password!.length < 6) {
            return 'A está muito curta.';
          }
          return null;
        },
      ),
    );

    forms.add(returnSizedBox(16));

    forms.add(
      ConfirmButtonWidget(
        onPress: () {
          validate = true;
          if (_key.currentState?.validate() ?? false) {
            setState(() {
              isLoading = true;
            });
            user = {
              'email': emailController.text,
              'password': passwordController.text,
            };
            userProvider.loginUser(user).then((response) {
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(response),
                ),
              );
            }).catchError((error) {
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error),
                ),
              );
            });
          }
        },
        title: 'Acessar conta',
      ),
    );

    return Scaffold(
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
                    children: forms,
                  ),
                ),
        ),
      ),
      drawer: AppDrawerWidget(),
    );
  }

  Widget returnSizedBox(double height) {
    return SizedBox(
      height: height,
    );
  }
}
