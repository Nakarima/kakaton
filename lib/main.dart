import 'package:flutter_web/material.dart';
import 'package:kakaton/LoginForm.dart';
import 'package:kakaton/MapPage.dart';

void main() => runApp(MyApp());

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

