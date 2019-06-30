import 'package:flutter_web/material.dart';
import 'package:firebase/firebase.dart' as firebase;


class MapPage extends StatefulWidget {
  MapPage({Key key}) : super(key: key);

  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Mapa zgłoszeń"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            DrawerHeader(
              child: Text("Menu"),
            ),
            InkWell(
                onTap: null,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          "Mapa",
                        style: TextStyle(
                          color: Colors.amber,
                        ),
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
                        builder: (context) => MapPage(),
                      ));
                },
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Dodaj zgłoszenie"),
                      Padding(
                        padding: EdgeInsets.all(3.0),
                      ),
                      Icon(Icons.add),
                    ],
                  ),
                )),
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
                      Text("Lista zgłoszeń"),
                      Padding(
                        padding: EdgeInsets.all(3.0),
                      ),
                      Icon(Icons.library_books),
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
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 56,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('map.png'),
              fit: BoxFit.fitHeight,
            )),
          ),
        ],
      ),
    );
  }
}
