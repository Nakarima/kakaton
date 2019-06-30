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
        title: Text("Logowanie"),
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
                Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('ekosrasz.png'),
                      fit: BoxFit.scaleDown,
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                ),
                RaisedButton(
                  color: Colors.amber[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {

                    startGoogleLogin();
                  },
                  child: Text('Zaloguj za pomocą Google'),
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
                  child: Text('Zaloguj za pomocą Facebook'),
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
                  child: Text('Zaloguj jako inspektor'),
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