import 'package:flutter_web/material.dart';
import 'package:kakaton/models/intervention.dart';
import 'package:kakaton/models/store.dart';
import 'package:firebase/firebase.dart' as firebase;

class NewInterventionForm extends StatefulWidget {
  NewInterventionForm({Key key}) : super(key: key);

  @override
  _NewInterventionFormState createState() => _NewInterventionFormState();
}

class _NewInterventionFormState extends State<NewInterventionForm> {
  final _formKey = GlobalKey<FormState>();

  String description;
  String phone;
  String adress;

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
                  firebase.auth().signOut();
                  Navigator.pushReplacementNamed(context, '/login');
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
                            description = value;
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
                            phone = value;
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
                            adress = value;
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

  void _sendDataBack(BuildContext context) async {
    _formKey.currentState.save();
    Intervention key;
    key = await store.interventions.add();
    if (key != null) {
      await store.interventions.submit(
          intervention: key,
          description: description,
          phone: phone,
          location: adress);
    }
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(key != null ? "Zgłoszenie wysłane" : "Nie udało się"),
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
