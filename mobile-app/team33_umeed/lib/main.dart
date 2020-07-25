import 'package:flutter/material.dart';
import 'package:team33_umeed/login.dart';
import 'package:team33_umeed/screens/tasks.dart';
import 'signup.dart';
import 'activities/homepage.dart';
import 'activities/dashboard.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new SignupPage(),
        '/login': (BuildContext context) => new Login(),
        '/home': (BuildContext context) => new HomeActivity(),
        '/dashboard':(_) => new Dashboard(),
        '/tasks': (_) => TasksScreen(),
      },
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Login();
  }
}
