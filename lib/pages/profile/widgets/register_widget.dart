// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/text_buttom_widget.dart';
import 'package:shop/controller/user.dart';
import 'package:shop/models/user.dart';
import 'package:shop/services/request_user.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  _RegideterPageState createState() => _RegideterPageState();
}

class _RegideterPageState extends State<RegisterWidget> {
  late RequestUserProvider userRequestProvider;
  late UserProvider userProvider;
  late UserModel user;

  TextEditingController cpfController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController();
  bool autoValidateForm = false;
  bool isLoading = false;
  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    userRequestProvider =
        Provider.of<RequestUserProvider>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);

    user = UserModel(
      email: '',
      password: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    final forms = <Widget>[];

    forms.add(
      TextFormField(
        controller: cpfController,
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
    forms.add(returnSizedBox(8));

    forms.add(
      TextFormField(
        controller: emailController,
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
        controller: passwordController,
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
    forms.add(returnSizedBox(16));

    forms.add(
      TextButtonWidget(
        onPress: () {
          autoValidateForm = true;
          if (_key.currentState!.validate()) {
            setState(() {
              isLoading = true;
            });

            _key.currentState!.save();

            user = UserModel(
              cpf: cpfController.text,
              email: emailController.text,
              password: passwordController.text,
              id: user.generateId(),
            );
            if (userProvider.addRegisterUser(user)) {
              userRequestProvider.registerUser(user).then((response) {
                setState(() {
                  isLoading = false;
                });
                returnScaffoldMassage(response, context);
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
              returnScaffoldMassage('Usuário já cadastrado!', context);
            }
          }
        },
        text: 'Criar conta',
      ),
    );

    return Scaffold(
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: forms,
                  ),
                ),
              ),
      ),
    );
  }

  Widget returnSizedBox(double height) {
    return SizedBox(
      height: height,
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      returnScaffoldMassage(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
