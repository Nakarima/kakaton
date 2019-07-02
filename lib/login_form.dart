import 'package:flutter_web/material.dart';
import 'package:firebase/firebase.dart' as firebase;


class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);


  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  _LoginFormState() : auth = firebase.auth();

  final auth;

  @override
  void initState() {
    authListener();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Login page"),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 56,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                RaisedButton(
                  color: Colors.amber[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {

                    startGoogleLogin();
                  },
                  child: Text('Log in with Google'),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                RaisedButton(
                  color: Colors.amber[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {

                    startGoogleLogin();
                  },
                  child: Text('Log in with Facebook'),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                RaisedButton(
                  color: Colors.amber[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {

                    Navigator.pushNamed(
                        context,
                       '/loginInspector',
                    );
                  },
                  child: Text('Log in as inspector'),
                )
              ],
            ),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void startGoogleLogin() async {
    var provider = firebase.GoogleAuthProvider();
    try {
      await firebase.auth().signInWithPopup(provider);
    } catch (e) {
      print(e);
    }
  }


  void authListener() {
    firebase.auth().onAuthStateChanged.listen((e) {
      if (e != null) {
        Navigator.pushReplacementNamed(
            context,
            '/normalUser');
      }
    });
  }

}