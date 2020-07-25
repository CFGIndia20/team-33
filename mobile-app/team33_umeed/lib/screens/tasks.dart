import 'package:flutter/material.dart';
import 'package:team33_umeed/services/database.dart';
import 'package:provider/provider.dart';
import 'package:team33_umeed/models/user.dart';
import 'package:team33_umeed/models/task.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthUser authUser = Provider.of<AuthUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: Container(
        height: 600,
        child: StreamBuilder<List<Task>>(
          builder: (context, snapshot) {
            return snapshot.data != null
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
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
          stream: Database().getUserTasks(authUser.uId),
        ),
      ),
    );
  }
}
