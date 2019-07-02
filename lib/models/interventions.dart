import 'dart:async';
import 'package:firebase/firebase.dart' as firebase;
import 'package:kakaton/models/intervention.dart';

class Interventions {
  final List<Intervention> _list = List<Intervention>();

  Stream<List<Intervention>> get() {
    var ref = firebase.database().ref("interventions");

    return ref.onValue.map((queryEvent) {
      var snapshot = queryEvent.snapshot;

      var newList = List<Intervention>();

      (snapshot.val() as Map<String, dynamic>).forEach((key, data) {
        
        var obj = _list.firstWhere(
          (x) => x.key == key,
          orElse: () => null);

        if (obj == null) {

          obj = Intervention(key: key);
        }

        newList.add(obj);

        obj
          ..dateTime = DateTime.parse(data["date"])
          ..contact = data["reporter"]
          ..description = data["desc"]
          ..phone = data["phone"]
          ..email = data["email"]
          ..status = data["status"]
          ..address = data["location"];
      });

      _list.clear();
      _list.addAll(newList);

      return _list;
    });
  }

  Future<Intervention> add() async {
    try {
      final result = 
        await firebase.functions().httpsCallable('createEmptyReport').call({});

      var obj = Intervention(
        key: result.data["key"]);

      _list.add(obj);

      return obj;

    } catch (e) {
      print(e);
    
      return null;
    }
  }

  Future submit({
    Intervention intervention, 
    String description, 
    String location, 
    String phone}) async {

    try {

      final result =
        await firebase.functions().httpsCallable('submitReport').call({
            'key': intervention.key,
            'desc': description,
            'location': location,
            'phone': phone
          });

    } catch (e) {

      print(e);
    }
  }

  Future delete({Intervention intervention}) async {

    try {

      _list.remove(intervention);

      final result = 
        await firebase.functions().httpsCallable('deleteReport').call({
            'key': intervention.key
          });


    } catch (e) {

      print (e);
    }
  }
}