import 'dart:async';
import 'package:firebase/firebase.dart' as firebase;
import 'package:kakaton/models/intervention.dart';

class Interventions {
  final List<Intervention> _list = List<Intervention>();

  Stream<List<Intervention>> get() {
    var ref = firebase.database().ref("interventions");

    return ref.onValue.map((queryEvent) {
      var snapshot = queryEvent.snapshot;

      (snapshot.val() as Map<String, dynamic>).forEach((key, data) {
        
        var obj = _list.firstWhere(
          (x) => x.key == key,
          orElse: () => null);

        if (obj == null) {

          obj = Intervention(key: key);

          _list.add(obj);
        }

        obj
          ..dateTime = DateTime.now()
          ..contact = data["reporter"]
          ..description = data["desc"]
          ..phone = data["phone"]
          ..email = data["email"]
          ..status = data["status"]
          ..adress = data["location"];
      });

      return _list;
    });
  }

  Future<String> add() async {
    try {
      final result = 
        await firebase.functions().httpsCallable('createEmptyReport').call({});

      return result.data["key"];
    } catch (e) {
      print(e);
    
      return null;
    }
  }

  Future submit({
    String key, 
    String description, 
    String location, 
    String phone}) async {

    try {

      final result =
        await firebase.functions().httpsCallable('submitReport').call({
            'key': key,
            'desc': description,
            'location': location,
            'phone': phone
          });
    } catch (e) {

      print(e);
    }
  }
}