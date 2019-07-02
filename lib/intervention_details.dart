import 'package:flutter_web/material.dart';
import 'package:kakaton/models/intervention.dart';
import 'package:kakaton/models/comment.dart';
import 'package:kakaton/models/store.dart';
import 'package:intl/intl.dart';
import 'package:kakaton/intervention_edit.dart';
import 'package:kakaton/widgets/comments_list.dart';

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
        title: Text("Details"),
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
                  "User: ${widget.intervention.contact}",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  "Phone number: ${widget.intervention.phone}",
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
                  "Address: ${widget.intervention.address}",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  "Date: ${DateFormat('yyyy-MM-dd kk:mm').format(widget.intervention.dateTime)}",
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
                  "Description: ${widget.intervention.description}",
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
                    child: Text('Edit'),
                  ),
                  RaisedButton(
                    color: Colors.amber[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                      _delete();
                    },
                    child: Text('Delete'),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text("Comments:"),
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
                      child: Text('Send comment'),
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
                default:
                  if(snapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.data.isEmpty) {
                    return Center(
                      child: Text("No comments"),
                    );
                  }
                  return CommentsList(snapshot.data);
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Comment sent"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
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

  void _delete() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Delete intervention?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new FlatButton(
                  child: new Text("Yes"),
                  onPressed: () {
                    store.interventions
                        .delete(intervention: widget.intervention);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/list', (Route<dynamic> route) => false);
                  },
                ),
                new FlatButton(
                  child: new Text("No"),
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
