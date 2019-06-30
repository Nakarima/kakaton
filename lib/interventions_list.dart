import 'package:flutter_web/material.dart';
import 'package:kakaton/models/intervention.dart';
import 'package:firebase/firebase.dart' as firebase;
import 'package:kakaton/models/store.dart';
import 'package:intl/intl.dart';
import 'package:kakaton/intervention_details.dart';

class InterventionsList extends StatefulWidget {
  InterventionsList({Key key}) : super(key: key);

  @override
  _InterventionsListState createState() => _InterventionsListState();
}

class _InterventionsListState extends State<InterventionsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista zgłoszeń'),
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
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/map', (Route<dynamic> route) => false);
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
                  Navigator.pushNamedAndRemoveUntil(context, '/inspectorNew',
                      (Route<dynamic> route) => false);
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
                      Text(
                        "Lista zgłoszeń",
                        style: TextStyle(
                          color: Colors.amber,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(3.0),
                      ),
                      Icon(
                        Icons.library_books,
                        color: Colors.amber,
                      ),
                    ],
                  ),
                )),
            InkWell(
                onTap: () {
                  firebase.auth().signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (Route<dynamic> route) => false);
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
      body: StreamBuilder<List<Intervention>>(
        stream: store.interventions.get(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Intervention>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.data.isEmpty) {
                return Center(
                  child: Text("Brak interwencji"),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 250,
                        width: 350,
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Card(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            InterventionDetails(
                                                intervention:
                                                    snapshot.data[index])));
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 5.0, top: 40.0),
                                      child: Text(
                                          "Użytkownik: ${snapshot.data[index].contact}"),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                          "Miejsce: ${snapshot.data[index].adress}"),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                          "Data: ${DateFormat('yyyy-MM-dd kk:mm').format(snapshot.data[index].dateTime)}"),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 5.0, bottom: 10.0),
                                      child: Text(
                                          "Status: ${snapshot.data[index].status}"),
                                    ),
                                    RaisedButton(
                                      color: Colors.amber[300],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    InterventionDetails(
                                                        intervention:
                                                        snapshot.data[index])));
                                      },
                                      child: Text('Szczegóły'),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              );
          }
        },
      ),
    );
  }
}
