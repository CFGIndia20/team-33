import 'package:flutter/material.dart';

class User {
  final String uId;
  final String name;
  final String email;
  final String phone;

  User({this.uId, this.name, this.email, this.phone});
}

class AuthUser {
  String uId;
  AuthUser({@required this.uId});
}
