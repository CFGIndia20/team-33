import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/task.dart';
import 'package:team33_umeed/models/user.dart';

class Database {
  final String uId;
  Database({this.uId});

  CollectionReference tasksCollection = Firestore.instance.collection('tasks');
  CollectionReference usersCollection = Firestore.instance.collection('users');

  User _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return User(
      email: snapshot.data['email'],
      name: snapshot.data['name'],
      phone: snapshot.data['phone'],
    );
  }

  Stream<List<Task>> getUserTasks(String userId) {
    try {
      return tasksCollection
          .orderBy('start')
          .where('user', isEqualTo: userId)
          .where('status', isEqualTo: 'Active')
          .snapshots()
          .map(getTasksFromQuerySnapshot);
    } catch (err) {
      print('Error getting user tasks: $err');
    }
  }

  Stream<User> getUser() {
    return usersCollection.document(uId).snapshots().map(_userDataFromSnapshot);
  }

  List<Task> getTasksFromQuerySnapshot(QuerySnapshot snap) {
    List<Task> userTasks = [];
    snap.documents.forEach((doc) {
      userTasks.add(Task.fromJSON(doc.documentID, doc.data));
    });
    return userTasks;
  }

  Future<void> addImageToTask(String taskId, String imageURL) async {
    try {
      return await tasksCollection
          .document(taskId)
          .updateData({'images': imageURL});
    } catch (err) {
      print('Error adding image to the task: $taskId');
    }
  }
}
