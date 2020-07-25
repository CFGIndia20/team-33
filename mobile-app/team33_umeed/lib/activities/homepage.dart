import 'package:flutter/material.dart';

class HomeActivity extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeActivity> {
  Widget _container() {
    var container = Container(
      margin: const EdgeInsets.all(10.0),
      color: Colors.pink[900],
      width: 100.0,
      height: 100.0,
    );
    return Container(
      color: Colors.white30,
      child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          padding: const EdgeInsets.all(2.0),
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 2.0,
          children: [
            container,
            container,
            container,
            container,
          ]),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Umeed'),
        ),
        body:
        Column(
         children: [RaisedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/tasks');
          },
          child: Text("tasks"),
        ),
        RaisedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/dashboard');
          },
          child: Text("dash"),
        ),
         ]
        )
        );
  }
}