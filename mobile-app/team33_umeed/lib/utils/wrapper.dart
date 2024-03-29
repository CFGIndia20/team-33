import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team33_umeed/activities/homepage.dart';
import 'package:team33_umeed/login.dart';
import 'package:team33_umeed/models/user.dart';
import 'package:team33_umeed/services/auth.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    AuthUser authUser = Provider.of<AuthUser>(context);
    // return authUser != null ? HomeActivity() : Login();

    return MultiProvider(
      providers: [
        StreamProvider<User>.value(
          value: AuthService().currentUser(authUser.uId),
        ),
      ],
      child: HomeActivity(),
    );
  }
}
