import 'package:flutter/material.dart';
import 'package:team33_umeed/models/task.dart';
import 'package:team33_umeed/services/database.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: Container(
        height: 600,
        child: StreamBuilder<Task>(
            stream: getUserTasks(id),
            builder: (context, snapshot) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text("1"),
                    ),
                    title: Text("task"),
                    subtitle: Text("date"),
                  );
                },
                itemCount: 10,
              );
            }),
      ),
    );
  }
}
