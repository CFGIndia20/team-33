import 'package:flutter/material.dart';
class HomeActivity extends StatefulWidget{
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeActivity>{

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
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          padding: const EdgeInsets.all(2.0),
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 2.0,
          children:[
            container,
            container,
            container,
            container,
          ]),
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
