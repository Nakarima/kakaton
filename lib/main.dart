import 'package:flutter_web/material.dart';
import 'package:kakaton/login_form.dart';
import 'package:kakaton/interventions_list.dart';
import 'package:kakaton/inspector_intervention_form.dart';
import 'package:kakaton/new_intervention_form.dart';
import 'package:kakaton/inspector_login_form.dart';
import 'package:kakaton/map_page.dart';
import 'package:firebase/firebase.dart' as firebase;

void main() {
  firebase.initializeApp(
    apiKey: "AIzaSyDkBGHnvSakkguKWj8bAXo0SCh4xBPGyZ8",
    authDomain: "interwencja-6029c.firebaseapp.com",
    databaseURL: "https://interwencja-6029c.firebaseio.com",
    projectId: "interwencja-6029c",
    storageBucket: "",
    messagingSenderId: "1034445272799");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        fontFamily: 'RobotoMono',
      ),
      home: LoginForm(),//asdd
      routes: <String, WidgetBuilder> {
        '/login': (BuildContext context) => new LoginForm(),
        '/loginInspector': (BuildContext context) => new InspectorLoginForm(),
        '/normalUser': (BuildContext context) => new NewInterventionForm(),
        '/map': (BuildContext context) => new MapPage(),
        '/inspectorNew': (BuildContext context) => new InspectorInterventionForm(),
        '/list': (BuildContext context) => new InterventionsList(),
      },
    );
  }
}

