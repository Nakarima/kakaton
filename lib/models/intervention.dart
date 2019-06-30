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
  String adress;

  Intervention({
    this.key,
    this.dateTime:null,
    this.contact:null,
    this.description:null,
    this.phone:null,
    this.email:null,
    this.status:null,
    this.adress:null});

  final List<Comment> _comments = List<Comment>();

  Stream<List<Comment>> get() {
    var ref = firebase.database().ref("interventions/" + key + "/comments");

    return ref.onValue.map((queryEvent) {
      var snapshot = queryEvent.snapshot;

      var newList = List<Comment>();

      (snapshot.val() as Map<String, dynamic>).forEach((key, data) {
        
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
          ..author = data["author"]
          ..authorEmail = data["authorEmail"]
          ..description = data["text"];
      });

      _comments.clear();
      _comments.addAll(newList);

      return _comments;
    });
  }

  Future addComment({String description}) async {
    try {

      final result = 
        await firebase.functions().httpsCallable('deleteReport').call({
            'key': this.key,
            'text': description
          });


    } catch (e) {

      print (e);
    }
  }
}