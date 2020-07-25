import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget{
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard>{
    Widget _container(){
      var container = Container(
            margin: const EdgeInsets.all(10.0),
            width: 100.0,
            height: 100.0,
            decoration: new BoxDecoration(
                        color: Colors.pink[900],
                        borderRadius: BorderRadius.circular(20),
                    ),
              
          );
        
        var cont =Container(
        color: Colors.white30,
        child: Column(
          children:[
          container,
          container,
          container,
          ]
        ),
        ); 
        return
        Center(child: cont);
    }

    Widget build(BuildContext context){
      return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.pink[900],
              title: Text('Umeed'),             
            ),
            body: _container()       );
    }
}