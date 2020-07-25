import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team33_umeed/login.dart';
import 'package:team33_umeed/screens/tasks.dart';
import 'package:team33_umeed/utils/wrapper.dart';
import 'signup.dart';
import 'activities/homepage.dart';
import 'activities/dashboard.dart';
import 'package:team33_umeed/models/user.dart';
import 'services/auth.dart';
import './screens/auth/auth.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new SignupPage(),
        '/login': (BuildContext context) => new Login(),
        '/home': (BuildContext context) => new HomeActivity(),
        '/dashboard': (_) => new Dashboard(),
        '/tasks': (_) => TasksScreen(),
      },
      home: MultiProvider(providers: [
        StreamProvider<AuthUser>.value(
          value: AuthService().authUser,
        ),
      ], child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fcm.configure(
      onMessage: (Map<String, dynamic> msg) async {
        print('Log: Notification onMessage: $msg');
        final snackBar = SnackBar(
          content: Text(msg['title']),
          action: SnackBarAction(
            label: 'Yes',
            onPressed: () {},
          ),
        );
        try {
          Scaffold.of(context).showSnackBar(snackBar);
        } catch (err) {
          print('Unable to open snackbar: $err');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthUser authUser = Provider.of<AuthUser>(context);
    return authUser == null ? Auth() : Wrapper();
  }
}