import 'package:flutter_web/material.dart';
import 'package:kakaton/models/intervention.dart';
import 'package:kakaton/models/store.dart';
import 'package:intl/intl.dart';
import 'package:kakaton/intervention_details.dart';
import 'package:kakaton/widgets/inspector_drawer.dart';

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
        title: Text('Interventions list'),
        centerTitle: true,
      ),
      drawer: InspectorDrawer(),
      body: StreamBuilder<List<Intervention>>(
        stream: store.interventions.get(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Intervention>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            default:
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.data.isEmpty) {
                return Center(
                  child: Text("No interventions"),
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
                                          "User: ${snapshot.data[index].contact}"),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                          "Address: ${snapshot.data[index].address}"),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                          "Date: ${DateFormat('yyyy-MM-dd kk:mm').format(snapshot.data[index].dateTime)}"),
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
                                      child: Text('Details'),
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
