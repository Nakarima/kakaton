import 'package:kakaton/models/comment.dart';
import 'package:firebase/firebase.dart' as firebase;

class Intervention {
  String key;
  DateTime dateTime;
  String contact;
  String description;
  String phone;
  String email;
  String status;
  String address;

  Intervention({
    this.key,
    this.dateTime:null,
    this.contact:null,
    this.description:null,
    this.phone:null,
    this.email:null,
    this.status:null,
    this.address:null});

  final List<Comment> _comments = List<Comment>();

  Stream<List<Comment>> get() {
    var ref = firebase.database().ref("interventions/" + key + "/comments");

    return ref.onValue.map((queryEvent) {
      var snapshotVal = queryEvent.snapshot.val() as Map<String, dynamic>;

      if (snapshotVal == null) {

        return _comments;
      }

      var newList = List<Comment>();

      snapshotVal.forEach((key, data) {
        
        var obj = _comments.firstWhere(
          (x) => x.key == key,
          orElse: () => null);

        if (obj == null) {

          obj = Comment(
            intervention: this,
            key: key);
        }

        newList.add(obj);

        obj
          ..dateTime = DateTime.parse(data["date"])
          ..authorEmail = data["authorEmail"]
          ..description = data["text"];
      });

      _comments.clear();
      _comments.addAll(newList.reversed);

      return _comments;
    });
  }

  Future edit({
    DateTime dateTime,
    String contact,
    String description,
    String phone,
    String email,
    String status,
    String location
    }) async {

    try {

      final result = 
        await firebase.functions().httpsCallable('editIntervention').call({
            'key': this.key,
            'date': dateTime.toIso8601String(),
            'reporter': contact,
            'desc': description,
            'phone': phone,
            'email': email,
            'status': status,
            'location': location
          });


    } catch (e) {

      print (e);
    }
  }

  Future addComment({String description}) async {
    try {

      final result = 
        await firebase.functions().httpsCallable('addCommentToReport').call({
            'key': this.key,
            'text': description
          });


    } catch (e) {

      print (e);
    }
  }
}