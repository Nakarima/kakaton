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
  String address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new intervention'),
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
                      Text("Log out"),
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
                              return 'Enter description';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: 'Description',
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
                              return 'Enter phone number';
                            } else if (value.length != 9 ||
                                double.tryParse(value) == null) {
                              return 'Invalid phone number';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Phone number',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          onSaved: (value) {
                            address = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter address';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: 'Address',
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
                          child: Text('Send'),
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
          location: address);
    }
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(key != null ? "Intervention sent" : "Failed"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
