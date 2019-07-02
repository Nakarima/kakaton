import 'package:flutter_web/material.dart';
import 'package:firebase/firebase.dart' as firebase;

class InspectorDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            onTap: goToRoute("/map", context),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Map",
                    style: TextStyle(
                      color: getColor("/map", context),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3.0),
                  ),
                  Icon(
                    Icons.map,
                    color:getColor("/map", context),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: goToRoute("/inspectorNew", context),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Add intervention",
                    style: TextStyle(
                      color: getColor("/inspectorNew", context),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3.0),
                  ),
                  Icon(
                    Icons.add,
                    color: getColor("/inspectorNew", context),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: goToRoute("/list", context),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Interventions list",
                    style: TextStyle(
                      color: getColor("/list", context),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3.0),
                  ),
                  Icon(
                    Icons.library_books,
                    color: getColor("/list", context),
                  ),
                ],
              ),
            ),
          ),
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
                  Text("Log out"),
                  Padding(
                    padding: EdgeInsets.all(3.0),
                  ),
                  Icon(Icons.exit_to_app),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  goToRoute(String path, BuildContext context) {
    if (ModalRoute.of(context).settings.name == path) {
      return null;
    }
    return () {
      Navigator.pushNamedAndRemoveUntil(
          context, path, (Route<dynamic> route) => false);
    };
  }

  getColor(String path, BuildContext context) {
    if (ModalRoute.of(context).settings.name == path) {
      return Colors.amber;
    }
    return Colors.black;
  }
}

