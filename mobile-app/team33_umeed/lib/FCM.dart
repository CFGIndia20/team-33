import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FCM extends StatefulWidget {
  @override
  _FCMState createState() => _FCMState();
}

class _FCMState extends State<FCM> {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      _fcm.configure(
        onMessage: (Map<String, dynamic> msg) async {
          print('Log: Notification onMessage: $msg');
          try {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('msg'),
              action: SnackBarAction(
                label: 'Yes',
                onPressed: () {},
              ),
            ));
          } catch (err) {
            print('Unable to open snackbar: $err');
          }
        },
        onLaunch: (Map<String, dynamic> msg) async {
          print('Log: Notification onMessage: $msg');
          try {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('msg'),
              action: SnackBarAction(
                label: 'Yes',
                onPressed: () {},
              ),
            ));
          } catch (err) {
            print('Unable to open snackbar: $err');
          }
        },
        onResume: (Map<String, dynamic> msg) async {
          print('Log: Notification onMessage: $msg');
          try {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('msg'),
              action: SnackBarAction(
                label: 'Yes',
                onPressed: () {},
              ),
            ));
          } catch (err) {
            print('Unable to open snackbar: $err');
          }
        },
        onBackgroundMessage: (Map<String, dynamic> msg) async {
          print('Log: Notification onMessage: $msg');
          try {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('msg'),
              action: SnackBarAction(
                label: 'Yes',
                onPressed: () {},
              ),
            ));
          } catch (err) {
            print('Unable to open snackbar: $err');
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
