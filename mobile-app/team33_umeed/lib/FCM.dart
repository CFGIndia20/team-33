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
            Scaffold.of(context).showBottomSheet((BuildContext context) {
              return Container(
                height: 200,
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Do you want to attend the session?'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          RaisedButton(
                            child: const Text('No'),
                            color: Colors.white,
                            onPressed: () => Navigator.pop(context),
                          ),
                          RaisedButton(
                            child: const Text('Yes'),
                            color: Colors.purple,
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
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
