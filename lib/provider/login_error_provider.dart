import 'dart:convert';
import 'dart:developer';

import 'package:book_app/model/login_error_model.dart';
import 'package:book_app/model/login_success_model.dart';
import 'package:book_app/provider/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginErrorProvider with ChangeNotifier {
  // LoginErrorModel? _loginErrorModel;
  // LoginSuccessModel? _loginSuccessModel;
  dynamic _loginResult;

  // LoginErrorModel? get loginErrorModel => _loginErrorModel;
  // LoginSuccessModel? get loginSuccessModel => _loginSuccessModel;
  dynamic get loginResult => _loginResult;

  Future<void> tryLogin(String usernameOrEmail, String password) async {
    final response = await http.post(
      Uri.parse("$WEB_URL/login.php"),
      body: {
        "username": usernameOrEmail,
        "password": password,
      },
    );

    final json = jsonDecode(response.body);
    log(response.body);

    if (json['status'] == 401) {
      try {
        _loginResult = LoginErrorModel.fromMap(json);
        notifyListeners();
      } catch (e) {
        log('error: $e');
      }
    } else {
      try {
        _loginResult = LoginSuccessModel.fromMap(json);
        notifyListeners();
      } catch (e) {
        log('error: $e');
      }
    }
  }
}
