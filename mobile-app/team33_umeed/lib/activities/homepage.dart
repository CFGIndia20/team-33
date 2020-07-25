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
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('Umeed'),
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(Icons.exit_to_app),
          //     onPressed: () async {
          //       await AuthService().signOut();
          //     },
          //   )
          // ],
          elevation: 0,
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.

          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  child: Image.asset(
                    'assets/lady.jpg',
                  ),
                  // backgroundImage: AssetImage('assets/lady.jpg'),
                ),
                accountName: Text("Akash Jindal"),
                accountEmail: Text("akashjindal347@gmail.com"),
              ),
              // DrawerHeader(

              //   child: Text('Drawer Header'),
              //   decoration: BoxDecoration(
              //     color: Colors.purple[600],
              //   ),
              // ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Account'),
                onTap: () async {
                  await AuthService().signOut();
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Log Out'),
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
              Stack(
                children: <Widget>[
                  Container(
                    height: 150,
                    width: double.infinity,
                    color: Colors.purple,
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
                    padding: EdgeInsets.only(
                      top: 80,
                    ),
                    child: Card(
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: Container(
                              transform:
                                  Matrix4.translationValues(0.0, -60.0, 0.0),
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                image: new DecorationImage(
                                  image: ExactAssetImage('assets/lady.jpg'),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Center(
                              child: Text(
                                "G.I. Joe",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: Center(
                              child: Text(
                                "Designation",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 60),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
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
                              return Card(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                //margin: EdgeInsets.symmetric(horizontal: 20.0),
                                elevation: 1.5,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return UploadImage(
                                          taskId: snapshot.data[index].id);
                                    }));
                                  },
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.purple[500],
                                    foregroundColor: Colors.white,
                                    child: Text("#1"),
                                  ),
                                  title: Text(snapshot.data[index].description),
                                  subtitle: Text("date"),
                                  trailing: Icon(
                                    Icons.arrow_forward,
                                  ),
                                ),
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
