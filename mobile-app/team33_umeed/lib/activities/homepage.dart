import 'package:flutter/material.dart';
import 'package:team33_umeed/services/auth.dart';
import 'package:team33_umeed/services/database.dart';
import 'package:provider/provider.dart';
import 'package:team33_umeed/models/user.dart';
import 'package:team33_umeed/models/task.dart';
import 'package:team33_umeed/upload.dart';

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
    AuthUser authUser = Provider.of<AuthUser>(context);
    print(authUser.uId);
    return Scaffold(
        appBar: AppBar(
          title: Text('Umeed'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.exit_to_app), onPressed: () async {
                  await AuthService().signOut();
                },
                )
          ],
        ),
        drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.purple[600],
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              // RaisedButton(
              //   onPressed: () {
              //     Navigator.of(context).pushNamed('/tasks');
              //   },
              //   child: Text("tasks"),
              // ),
              //  RaisedButton(
              //   onPressed: () async {
              //     await AuthService().signOut();
              //   },
              //   child: Text("logout"),
              // ),
              Expanded(
                child: StreamBuilder<List<Task>>(
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      //print(snapshot.data.length);
                      print(snapshot.data.length);
                    }
                    
                    return snapshot.data != null
                        ? ListView.builder(
                            itemBuilder: (context, index) {
                              return ListTile(
                                contentPadding: const EdgeInsets.all(10.0),
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return UploadImage(
                                        taskId: snapshot.data[index].id);
                                  }));
                                },
                                leading: CircleAvatar(
                                  child: Text(snapshot.data[index].name),
                                ),
                                title: Text(snapshot.data[index].description),
                                subtitle: Text("date"),
                                
                              );
                            },
                            itemCount: snapshot.data.length,
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                  stream: Database()
                      .getUserTasks(authUser.uId)
                      .handleError((onError) {
                    print(onError);
                  }),
                ),
              )
            ])
        // Text("test"),
        );
  }
}