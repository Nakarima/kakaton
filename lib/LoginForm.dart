import 'package:flutter_web/material.dart';
import 'package:firebase/firebase.dart' as fire;
import 'package:kakaton/NewInterventionForm.dart';


class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);


  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  //_LoginFormState() : auth = fire.auth();

  //final auth;

  @override
  void initState() {
    //authListener();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("logowanie"),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                color: Colors.amber[300],
                onPressed: () {

                  startGoogleLogin();
                },
                child: Text('Zaloguj z google'),
              )
            ],
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void startGoogleLogin() async {
    var provider = fire.GoogleAuthProvider();
    try {
      await fire.auth().signInWithRedirect(provider);
    } catch (e) {
      print("kupa");
    }
  }

  void authListener() {
    fire.auth().onAuthStateChanged.listen((e) {
      if (e != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewInterventionForm(),
            ));
      }
    });
  }

}