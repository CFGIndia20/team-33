import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var _auth = FirebaseAuth.instance;

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var _isLoading = false;

  void handleRegister() async {
    AuthResult authResult;
    try {
      setState(() {
        _isLoading = true;
      });

      authResult = await _auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      print(authResult);

      // Navigator.of(context).pushReplacementNamed('');
    } on PlatformException catch (err) {
      var message = 'An error occurred, pelase check your credentials!';

      if (err.message != null) {
        message = err.message;
      }

      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: _isLoading
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                            child: Text(
                              'Signup',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 80.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.fromLTRB(300.0, 125.0, 0.0, 0.0),
                            child: Text(
                              '.',
                              style: TextStyle(
                                  fontSize: 80.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                        padding:
                            EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                        child: Column(
                          children: <Widget>[
                            TextField(
                              decoration: InputDecoration(
                                  labelText: 'EMAIL',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  // hintText: 'EMAIL',
                                  // hintStyle: ,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.purple))),
                            ),
                            // TextField(
                            //   decoration: InputDecoration(
                            //     labelText: 'PHONE',
                            //     labelStyle: TextStyle(
                            //         fontFamily: 'Montserrat',
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.grey),
                            //     // hintText: 'EMAIL',
                            //     // hintStyle: ,

                            //     focusedBorder: UnderlineInputBorder(
                            //         borderSide: BorderSide(color: Colors.purple)),
                            //   ),
                            //   controller: emailController,
                            //   keyboardType: TextInputType.number,
                            // ),
                            SizedBox(height: 10.0),
                            TextField(
                              decoration: InputDecoration(
                                  labelText: 'PASSWORD ',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.purple))),
                              controller: passwordController,
                              obscureText: true,
                            ),
                            SizedBox(height: 50.0),
                            Container(
                                height: 40.0,
                                child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  shadowColor: Colors.purpleAccent,
                                  color: Colors.purple,
                                  elevation: 7.0,
                                  child: GestureDetector(
                                    onTap: handleRegister,
                                    child: Center(
                                      child: Text(
                                        'SIGNUP',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat'),
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(height: 20.0),
                            Container(
                              height: 40.0,
                              color: Colors.transparent,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                        width: 1.0),
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Center(
                                    child: Text('Go Back',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat')),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ])
            : CircularProgressIndicator());
  }
}
