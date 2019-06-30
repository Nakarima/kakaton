import 'package:flutter_web/material.dart';
import 'package:kakaton/models/intervention.dart';
import 'package:kakaton/models/comment.dart';
import 'package:kakaton/models/store.dart';
import 'package:intl/intl.dart';
import 'package:kakaton/intervention_edit.dart';
import 'package:kakaton/new_comment.dart';

class InterventionDetails extends StatefulWidget {
  InterventionDetails({Key key, this.intervention}) : super(key: key);

  final Intervention intervention;

  _InterventionDetailsState createState() => _InterventionDetailsState();
}

class _InterventionDetailsState extends State<InterventionDetails> {
  final _formKey = GlobalKey<FormState>();
  String description;

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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InterventionEdit(
                                  intervention: widget.intervention)));
                    },
                    child: Text('Edytuj'),
                  ),
                  RaisedButton(
                    color: Colors.amber[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                      _delete();
                    },
                    child: Text('Usuń'),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text("Komentarze:"),
          ),
          SizedBox(
            width: 600.0,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      onSaved: (value) {
                        description = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Wprowadź opis';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: 'Opis',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: RaisedButton(
                      color: Colors.amber[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _sendDataBack(context);
                        }
                      },
                      child: Text('Wyślij komentarz'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          StreamBuilder<List<Comment>>(
            stream: widget.intervention.get(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Comment>> snapshot) {
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
                      child: Text("Brak komentarzy"),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
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
                                  child: Container(
                                    width: 100,
                                    height: 50,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Text(
                                              "Data: ${DateFormat('yyyy-MM-dd kk:mm').format(snapshot.data[index].dateTime)}"),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Text(
                                              "Email: ${snapshot.data[index].authorEmail}"),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 5.0, bottom: 10.0),
                                          child: Text(
                                              "${snapshot.data[index].description}"),
                                        ),
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
          Padding(
            padding: EdgeInsets.all(15.0),
          )
        ],
      ),
    );
  }

  void _sendDataBack(BuildContext context) {
    _formKey.currentState.save();
    widget.intervention.addComment(description: description);
    // Todo add to intervention
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Komentarz dodany"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Zamknij"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    //Navigator.pop(context, result);
  }

  void _delete() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Usunąć interwencje?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new FlatButton(
                  child: new Text("Tak"),
                  onPressed: () {
                    store.interventions
                        .delete(intervention: widget.intervention);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/list', (Route<dynamic> route) => false);
                  },
                ),
                new FlatButton(
                  child: new Text("Nie"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
