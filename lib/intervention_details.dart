import 'package:flutter_web/material.dart';
import 'package:kakaton/models/intervention.dart';
import 'package:intl/intl.dart';

class InterventionDetails extends StatefulWidget {
  InterventionDetails({Key key, this.intervention}) : super(key: key);

  final Intervention intervention;

  _InterventionDetailsState createState() => _InterventionDetailsState();
}

class _InterventionDetailsState extends State<InterventionDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Szczegóły"),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 5.0, top: 40.0),
                child: Text(
                  "Użytkownik: ${widget.intervention.contact}",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  "Telefon: ${widget.intervention.phone}",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  "Email: ${widget.intervention.email}",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  "Miejsce: ${widget.intervention.adress}",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  "Data: ${DateFormat('yyyy-MM-dd kk:mm').format(widget.intervention.dateTime)}",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  "Status: ${widget.intervention.status}",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                child: Text(
                  "Opis: ${widget.intervention.description}",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Wrap(
                spacing: 8.0,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.amber[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {},
                    child: Text('Edytuj'),
                  ),
                  RaisedButton(
                    color: Colors.amber[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {},
                    child: Text('Dodaj Komentarz'),
                  ),
                  RaisedButton(
                    color: Colors.amber[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {},
                    child: Text('Usuń'),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
