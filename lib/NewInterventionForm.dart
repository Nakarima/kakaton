import 'package:flutter_web/material.dart';
import 'package:kakaton/Models/Intervention.dart';
import 'package:firebase/firebase.dart';

class NewInterventionForm extends StatefulWidget {
  NewInterventionForm({Key key}) : super(key: key);

  @override
  _NewInterventionFormState createState() => _NewInterventionFormState();
}

class _NewInterventionFormState extends State<NewInterventionForm> {
  final _formKey = GlobalKey<FormState>();

  Intervention _intervention = new Intervention();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nowe zgłoszenie'),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 600.0,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Dodaj zgłoszenie",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          onSaved: (value) { _intervention.description = value; },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Wprowadź opis zdarzenia';
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
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          onSaved: (value) { _intervention.phone = value; },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Wprowadź numer telefonu';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Numer Telefonu',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          onSaved: (value) { _intervention.email = value; },
                          validator: (value) {
                            Pattern pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = new RegExp(pattern);
                            if (!regex.hasMatch(value)) {
                              return "Wprowadź email";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          onSaved: (value) { _intervention.adress = value; },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Wprowadź adres';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: 'Adres',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: RaisedButton(
                          color: Colors.amber[300],
                          onPressed: () {

                            if (_formKey.currentState.validate()) {
                              _sendDataBack(context);
                            }
                          },
                          child: Text('Wyślij'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _sendDataBack(BuildContext context) {
    _formKey.currentState.save();
    _intervention.dateTime = DateTime.now();
    Intervention result = _intervention;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Zgłoszenie wysłane"),
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
}
