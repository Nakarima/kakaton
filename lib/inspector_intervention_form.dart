import 'package:flutter_web/material.dart';
import 'package:kakaton/widgets/inspector_drawer.dart';
import 'package:intl/intl.dart';

class InspectorInterventionForm extends StatefulWidget {
  InspectorInterventionForm({Key key}) : super(key: key);

  @override
  _InspectorInterventionFormState createState() =>
      _InspectorInterventionFormState();
}

class _InspectorInterventionFormState extends State<InspectorInterventionForm> {
  final _formKey = GlobalKey<FormState>();

  String description;
  String phone;
  String address;
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime datePicked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    final DateTime picked = new DateTime(datePicked.year, datePicked.month,
        datePicked.day, selectedDate.hour, selectedDate.minute);
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay timePicked = await showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: selectedDate.hour, minute: selectedDate.minute),
    );
    final DateTime picked = new DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, timePicked.hour, timePicked.minute);
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new intervention'),
        centerTitle: true,
      ),
      drawer: InspectorDrawer(),
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
                        padding: EdgeInsets.only(top: 10, bottom: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Date: ${DateFormat('yyyy-MM-dd kk:mm').format(selectedDate)}",
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
                                  child: Text('Select date'),
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
                                  child: Text('Select time'),
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

  void _sendDataBack(BuildContext context) {
    _formKey.currentState.save();
    //TODO
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Intervention sent"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
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
