import 'package:flutter/material.dart';
import 'package:team33_umeed/login.dart';
import 'package:team33_umeed/signup.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  String mode = '/login';

  void changeAuth() {
    if (mode == '/login') {
      setState(() {
        mode = '/signup';
      });
    } else {
      setState(() {
        mode = '/login';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return mode == '/login'
        ? Login(
            changeAuth: changeAuth,
          )
        : SignupPage(changeAuth: changeAuth);
  }
}
