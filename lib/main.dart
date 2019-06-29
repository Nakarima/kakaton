import 'package:flutter_web/material.dart';
import 'package:kakaton/MapPage.dart';
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
      home: MapPage(),//asdd
    );
  }
}

