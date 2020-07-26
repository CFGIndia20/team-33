import 'package:flutter/material.dart';
import 'package:team33_umeed/FCM.dart';
import 'package:team33_umeed/services/auth.dart';
import 'package:team33_umeed/services/database.dart';
import 'package:provider/provider.dart';
import 'package:team33_umeed/models/user.dart';
import 'package:team33_umeed/models/task.dart';
import 'package:team33_umeed/upload.dart';
import 'package:team33_umeed/models/language.dart';
import 'package:team33_umeed/main.dart';
import 'package:team33_umeed/localization/localization.dart';

class HomeActivity extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeActivity> {
  void _changeLanguage(Language language) {
    Locale _temp;
    switch (language.languageCode) {
      case "en":
        _temp = Locale(language.languageCode, "US");
        break;
      case "hi":
        _temp = Locale(language.languageCode, "IN");
        break;
      // case "fa":
      //   _temp = Locale(language.languageCode, "IR");
      //   break;
      // case "ar":
      //   _temp = Locale(language.languageCode, "SA");
      //   break;
      default:
        _temp = Locale(language.languageCode, "US");
    }
    MyApp.setLocale(context, _temp);
    print(language.languageCode);
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
          title:
              Text(DemoLocalization.of(context).getTranslatedValues('umeed')),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton(
                icon: Icon(
                  Icons.language,
                  color: Colors.white,
                ),
                items: Language.languagesList()
                    .map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
                          value: lang,
                          child: Row(
                            children: <Widget>[
                              Text(lang.flag),
                              SizedBox(
                                width: 5,
                              ),
                              Text(lang.name),
                            ],
                          ),
                        ))
                    .toList(),
                onChanged: (language) {
                  _changeLanguage(language);
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await AuthService().signOut();
              },
            )
          ],
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
                accountName: Text("GI Joe"),
                accountEmail: Text("gijoe@gmail.com"),
              ),
              // DrawerHeader(

              //   child: Text('Drawer Header'),
              //   decoration: BoxDecoration(
              //     color: Colors.purple[600],
              //   ),
              // ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text(DemoLocalization.of(context)
                    .getTranslatedValues('account')),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.of(context).pushReplacementNamed('/login');
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(DemoLocalization.of(context)
                    .getTranslatedValues('settings')),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text(
                    DemoLocalization.of(context).getTranslatedValues('logout')),
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
              FCM(),

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
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 8),
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
                                    child: Text('#' +
                                        snapshot.data[index].quantity
                                            .toString()),
                                  ),
                                  title: Text(snapshot.data[index].name),
                                  subtitle: Text(
                                      snapshot.data[index].start.toString() +
                                          '-' +
                                          snapshot.data[index].end.toString()),
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
