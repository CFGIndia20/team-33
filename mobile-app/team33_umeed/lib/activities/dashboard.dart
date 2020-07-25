import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget{
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard>{
    Widget _container(){
        var cont =Container(
        color: Colors.white30,
        child: Column(
          children:[

          Container(
            margin: const EdgeInsets.all(10.0),
            width: 400.0,
            height: 200.0,
            decoration: new BoxDecoration(
                        color: Colors.pink[900],
                        borderRadius: BorderRadius.circular(20),
                    ),
            child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                child: Image.asset('images/use.jpg'),
              ),
              title: Text("task"),
              subtitle: Text("date"),
            );
          },
          itemCount: 1,
          //  child: Row(
          //    children:[Image.asset('images/user.jpg'),
          //    Text("fsjdfdsd")
          //    ],)
            )   
          ),

          Container(
            margin: const EdgeInsets.all(10.0),
            width: 400.0,
            height: 200.0,
            decoration: new BoxDecoration(
                        color: Colors.pink[900],
                        borderRadius: BorderRadius.circular(20),
                    ),
            child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                child: Image.asset('images/use.jpg'),
              ),
              title: Text("task"),
              subtitle: Text("date"),
            );
          },
          itemCount: 1,
          //  child: Row(
          //    children:[Image.asset('images/user.jpg'),
          //    Text("fsjdfdsd")
          //    ],)
            )   
          ),

          Container(
            margin: const EdgeInsets.all(10.0),
            width: 400.0,
            height: 200.0,
            decoration: new BoxDecoration(
                        color: Colors.pink[900],
                        borderRadius: BorderRadius.circular(20),
                    ),
            child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                child: Image.asset('images/use.jpg'),
              ),
              title: Text("task"),
              subtitle: Text("date"),
            );
          },
          itemCount: 1,
          //  child: Row(
          //    children:[Image.asset('images/user.jpg'),
          //    Text("fsjdfdsd")
          //    ],)
            )   
          ),

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