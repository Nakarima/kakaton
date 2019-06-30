import 'package:flutter_web/material.dart';
import 'package:firebase/firebase.dart' as firebase;
import 'package:kakaton/MapPage.dart';

class InspectorLoginForm extends StatefulWidget {
  InspectorLoginForm({Key key}) : super(key: key);

  _InspectorLoginFormState createState() => _InspectorLoginFormState();
}

class _InspectorLoginFormState extends State<InspectorLoginForm> {
  _InspectorLoginFormState() : auth = firebase.auth();

  final auth;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    authListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Logowanie jako inspektor"),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 600.0,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          onSaved: (value) {
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Wprowadź login';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Login',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          obscureText: true,
                          onSaved: (value) {
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Wprowadź haslo';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Hasło',
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: RaisedButton(
                          color: Colors.amber[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              //TODO zmienic na normalna funkcje

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapPage(),
                                  ));
                            }
                          },
                          child: Text('Zaloguj'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

 // TODO logowanie

  void authListener() {
    firebase.auth().onAuthStateChanged.listen((e) {
      if (e != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MapPage(),
            ));
      }
    });
  }
}
