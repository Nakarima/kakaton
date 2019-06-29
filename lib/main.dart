import 'package:flutter_web/material.dart';
import 'package:kakaton/NewInterventionForm.dart';
import 'package:kakaton/Models/Intervention.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Intervention intervention;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _newIntervention(context),
      ),
      body: ListView(
        children: <Widget>[
         Text(
           intervention != null ? intervention.description : "dupa"
         ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _newIntervention(BuildContext context) async {

    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewInterventionForm(),
        ));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      intervention = result;
    });
  }
}
