import 'package:flutter_web/material.dart';
import 'package:kakaton/widgets/inspector_drawer.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key}) : super(key: key);

  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Interventions map"),
        centerTitle: true,
      ),
      drawer: InspectorDrawer(),
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
