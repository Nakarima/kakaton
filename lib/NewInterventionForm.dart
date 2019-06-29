import 'package:flutter_web/material.dart';
import 'package:kakaton/Models/Intervention.dart';

class NewInterventionForm extends StatefulWidget {
  NewInterventionForm({Key key}) : super(key: key);

  @override
  _NewInterventionFormState createState() => _NewInterventionFormState();
}

class _NewInterventionFormState extends State<NewInterventionForm> {
  final _formKey = GlobalKey<FormState>();

  Intervention _intervention;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Wprowadź opis zdarzenia';
                  }
                  return null;
                },
                onSaved: ,
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
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text('Przetwarzanie')));
                  }
                },
                child: Text('Wyślij'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
