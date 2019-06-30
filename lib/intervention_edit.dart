import 'package:flutter_web/material.dart';
import 'package:kakaton/models/intervention.dart';
import 'package:intl/intl.dart';

class InterventionEdit extends StatefulWidget {
  InterventionEdit({Key key, this.intervention}) : super(key: key);

  final Intervention intervention;

  @override
  _interventionEditState createState() => _interventionEditState();
}

class _interventionEditState extends State<InterventionEdit> {
  final _formKey = GlobalKey<FormState>();

  String description;
  String contact;
  String name;
  String adress;
  String status;
  String phone;
  String email;


  DateTime selectedDate;
  List _statuses =
  ["creating", "pendingVerification", "pendingAction", "inProgress", "closed"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;




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
  void initState() {
    selectedDate = widget.intervention.dateTime;
    status = widget.intervention.status;
    _dropDownMenuItems = getDropDownMenuItems();
    super.initState();
  }
  // here we are creating the list needed for the DropDownButton
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String status in _statuses) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(
          value: status,
          child: new Text(status)
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edytuj zgłoszenie'),
        centerTitle: true,
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
                          initialValue: widget.intervention.description,
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
                          initialValue: widget.intervention.contact,

                          onSaved: (value) {
                            contact = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Wprowadź imie i nazwisko';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: 'Imie i nazwisko',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          initialValue: widget.intervention.email,

                          onSaved: (value) {
                            email = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Wprowadź email';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: 'Email',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          initialValue: widget.intervention.phone,

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
                          initialValue: widget.intervention.adress,

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
                        padding: EdgeInsets.all(10),
                      ),
                      new Text(
                        "status",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      new Container(
                        padding: new EdgeInsets.all(3.0),
                      ),
                      new DropdownButton(
                        value: status,
                        items: _dropDownMenuItems,
                        onChanged: changedDropDownItem,
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
    widget.intervention.edit(dateTime: selectedDate, contact: contact, description: description, phone: phone, email: email, location: adress, status: status);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Zgłoszenie edytowane"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Powrót"),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/list', (Route<dynamic> route) => false);
              },
            ),
          ],
        );
      },
    );
    //Navigator.pop(context, result);
  }

  void changedDropDownItem(String newStatus) {
    setState(() {
      status = newStatus;
    });
  }
}
