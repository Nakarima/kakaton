import 'package:flutter_web/material.dart';
import 'package:kakaton/models/intervention.dart';
import 'package:firebase/firebase.dart' as firebase;
import 'package:kakaton/map_page.dart';
import 'package:kakaton/inspector_intervention_form.dart';
import 'package:intl/intl.dart';


class InterventionsList extends StatefulWidget {
  InterventionsList({Key key}) : super(key: key);

  @override
  _InterventionsListState createState() => _InterventionsListState();
}

class _InterventionsListState extends State<InterventionsList> {
  final _formKey = GlobalKey<FormState>();

  Intervention _intervention = new Intervention();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dodaj nowe zgłoszenie'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                "Menu",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapPage(),
                      ));
                },
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Mapa",
                      ),
                      Padding(
                        padding: EdgeInsets.all(3.0),
                      ),
                      Icon(Icons.map),
                    ],
                  ),
                )),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InspectorInterventionForm(),
                      ));
                },
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Dodaj zgłoszenie",
                      ),
                      Padding(
                        padding: EdgeInsets.all(3.0),
                      ),
                      Icon(
                        Icons.add,
                      ),
                    ],
                  ),
                )),
            InkWell(
                onTap: null,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Lista zgłoszeń", style: TextStyle(
                        color: Colors.amber,
                      ),),
                      Padding(
                        padding: EdgeInsets.all(3.0),
                      ),
                      Icon(Icons.library_books, color: Colors.amber,),
                    ],
                  ),
                )),
            InkWell(
                onTap: () {
                  firebase.auth().signOut();
                  Navigator.popUntil(
                      context, ModalRoute.withName(Navigator.defaultRouteName));
                },
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Wyloguj się"),
                      Padding(
                        padding: EdgeInsets.all(3.0),
                      ),
                      Icon(Icons.exit_to_app),
                    ],
                  ),
                ))
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[

        ],
      ),
    );
  }


}
