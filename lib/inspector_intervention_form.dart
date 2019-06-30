import 'package:flutter_web/material.dart';
import 'package:kakaton/models/intervention.dart';
import 'package:firebase/firebase.dart' as firebase;
import 'package:kakaton/map_page.dart';
import 'package:intl/intl.dart';
import 'package:kakaton/interventions_list.dart';

class InspectorInterventionForm extends StatefulWidget {
  InspectorInterventionForm({Key key}) : super(key: key);

  @override
  _InspectorInterventionFormState createState() =>
      _InspectorInterventionFormState();
}

class _InspectorInterventionFormState extends State<InspectorInterventionForm> {
  final _formKey = GlobalKey<FormState>();

  Intervention _intervention = new Intervention();
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime datePicked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    final DateTime picked = new DateTime(datePicked.year, datePicked.month,
        datePicked.day, selectedDate.hour, selectedDate.minute);
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay timePicked = await showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: selectedDate.hour, minute: selectedDate.minute),
    );
    final DateTime picked = new DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, timePicked.hour, timePicked.minute);
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

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
                  Navigator.pushNamedAndRemoveUntil(context, '/map', (Route<dynamic> route) => false);

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
                onTap: null,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Dodaj zgłoszenie",
                        style: TextStyle(
                          color: Colors.amber,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(3.0),
                      ),
                      Icon(
                        Icons.add,
                        color: Colors.amber,
                      ),
                    ],
                  ),
                )),
            InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/list', (Route<dynamic> route) => false);

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
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);

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
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          onSaved: (value) {
                            _intervention.description = value;
                          },
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
                          onSaved: (value) {
                            _intervention.phone = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Wprowadź numer telefonu';
                            } else if (value.length != 9 ||
                                double.tryParse(value) == null) {
                              return 'Niepoprawny numer telefony';
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
                          onSaved: (value) {
                            _intervention.adress = value;
                          },
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
                        padding: EdgeInsets.only(top: 10, bottom: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Data: ${DateFormat('yyyy-MM-dd kk:mm').format(selectedDate)}",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RaisedButton(
                                  color: Colors.amber[300],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  onPressed: () => _selectDate(context),
                                  child: Text('Wybierz datę'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                ),
                                RaisedButton(
                                  color: Colors.amber[300],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  onPressed: () => _selectTime(context),
                                  child: Text('Wybierz czas'),
                                ),
                              ],
                            )
                          ],
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
