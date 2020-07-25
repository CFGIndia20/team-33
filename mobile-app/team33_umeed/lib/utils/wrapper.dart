import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team33_umeed/activities/homepage.dart';
import 'package:team33_umeed/login.dart';
import 'package:team33_umeed/models/user.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return user != null ? HomeActivity() : Login();
  }
}
