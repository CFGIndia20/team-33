import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team33_umeed/login.dart';
import 'package:team33_umeed/screens/tasks.dart';
import 'package:team33_umeed/utils/wrapper.dart';
import 'signup.dart';
import 'activities/homepage.dart';
import 'activities/dashboard.dart';
import 'package:team33_umeed/models/user.dart';
import 'services/auth.dart';
import './screens/auth/auth.dart';
import 'localization/localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      locale: _locale,
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        DemoLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (locale.languageCode == deviceLocale.languageCode &&
              locale.countryCode == deviceLocale.countryCode) {
            return locale;
          }
        }
        return supportedLocales.first;
      },
      supportedLocales: [
        Locale('en', 'US'),
        Locale('fa', 'IR'),
        Locale('ar', 'SA'),
        Locale('hi', 'IN'),
      ],
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new SignupPage(),
        '/login': (BuildContext context) => new Login(),
        '/home': (BuildContext context) => new HomeActivity(),
        '/dashboard': (_) => new Dashboard(),
        '/tasks': (_) => TasksScreen(),
      },
      home: MultiProvider(providers: [
        StreamProvider<AuthUser>.value(
          value: AuthService().authUser,
        ),
      ], child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthUser authUser = Provider.of<AuthUser>(context);
    return authUser == null ? Auth() : Wrapper();
  }
}
