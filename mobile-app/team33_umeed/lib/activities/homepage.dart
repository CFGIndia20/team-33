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
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () async {
                  await AuthService().signOut();
                },
                child: Text("logout"),
              ),
              // RaisedButton(
              //   onPressed: () {
              //     Navigator.of(context).pushNamed('/tasks');
              //   },
              //   child: Text("tasks"),
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
