import 'dart:developer';

import 'package:book_app/model/login_error_model.dart';
import 'package:book_app/model/login_success_model.dart';
import 'package:book_app/pages/route_path.dart';
import 'package:book_app/provider/login_error_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameOrEmailController = TextEditingController();
  TextEditingController passwordController =
      TextEditingController(text: "ee11cbb19052e40b07aac0ca060c23ee");
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void tryLogin(
    String usernameOrEmail,
    String password,
  ) async {
    final result = await context
        .read<LoginErrorProvider>()
        .tryLogin(usernameOrEmail, password);

    if (context.mounted) {
      if (result is LoginSuccessModel) {
        Navigator.of(context).pushNamed(
          RoutePath.homePage,
        );

        setTokenKey(result);
        log('login success');
      } else if (result is LoginErrorModel) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('wrong username or password'),
          ),
        );

        log('login error');
      }
    }
  }

  void setTokenKey(LoginSuccessModel loginSuccessModel) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt('token', loginSuccessModel.token);
  }

  @override
  void dispose() {
    usernameOrEmailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const Positioned.fill(
            //
            child: Image(
              image: AssetImage('assets/images/bg.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          Consumer<LoginErrorProvider>(
            builder: (context, value, child) {
              // final loginError = value.loginErrorModel;
              // final loginSuccess = value.loginSuccessModel;
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    const Text(
                      'Welcome Back! ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                    const Text(
                      'Enter your username and password',
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    TextField(
                      controller: usernameOrEmailController,
                      decoration: const InputDecoration(
                        hintText: "Username",
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        hintText: "Password",
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        //test api login
                        if (usernameOrEmailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          tryLogin(
                            usernameOrEmailController.text,
                            passwordController.text,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('textfield is empty'),
                            ),
                          );
                        }
                      },
                      child: const SizedBox(
                        width: 100,
                        child: Center(
                          child: Text("Login"),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
