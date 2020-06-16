import 'package:auto_center/Pages/ClientScreen.dart';
import 'package:auto_center/Pages/ButtomNavigationPage.dart';
import 'package:auto_center/Pages/test/SearchC.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: LoginPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
      SingleChildScrollView(

          child: Form(
            key: _formKey,
            child: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    "Images/mechanic_2x.jpg",
                    width: double.maxFinite,

                  ),
                  Positioned(
                    top: 35,
                    left: 30,
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Positioned(
                    top: 240,
                    child: Container(
                      padding: EdgeInsets.all(45),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60))),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextFormField(
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter your E-mail ';
                              }
                              return null;
                            },
                            onSaved: (value) => _email = value,
                            autofocus: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                icon: Icon(Icons.email),
                                contentPadding:
                                EdgeInsets.fromLTRB(30.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0)),
                                hintText: 'E-mail'),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16, bottom: 32),
                            child: TextFormField(
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your password';
                                  } else if (value.length < 6) {
                                    return 'pass needs at least 6 characters';
                                  }
                                  return null;
                                },
                                onSaved: (value) => _password = value,
                                autofocus: false,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.lock),
                                    contentPadding:
                                    EdgeInsets.fromLTRB(30.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(32.0)),
                                    hintText: 'Password'),
                                obscureText: true),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: RaisedButton(
                                    color: Colors.deepPurple,
                                    elevation: 10.0,
                                    padding: const EdgeInsets.all(15.0),
                                    textColor: Colors.white,
                                    child: Text('Login'),
                                    onPressed: signIn,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(height: 8),
                          Text(
                            "Do not forget your password",
                            style: TextStyle(color: Colors.deepPurple),
                          ),
                          Container(
                            height: 35,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                                child: Center(
                                  child: Icon(Icons.face),
                                ),
                              ),
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                                child: Center(
                                  child: Icon(Icons.fingerprint),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      print(_email + " " + _password );
      if (!(_email.toLowerCase().contains("@gmail.com"))){
        _email += "@gmail.com";
        /*try {
          AuthResult user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
//          Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigationPage())); // with back
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (BuildContext context) => BottomNavigationPage())); // without back
        } catch (e) {
          e.message;
        }*/
      }
      if (_email.toLowerCase() == "auto-center@gmail.com" &&
          _password.toLowerCase() == "123456") {
        try {
          //AuthResult user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
//          Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigationPage())); // with back
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (BuildContext context) => BottomNavigationPage())); // without back
        } catch (e) {
          e.message;
        }
      } else {
        _showDialog();
      }
    }
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("E-mail or Password incorrect"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
