import 'dart:async';
import 'package:firebase/firebase.dart' as firebase;
import 'package:kakaton/models/intervention.dart';

class Interventions {
  Stream<List<Intervention>> get() {
    var ref = firebase.database().ref("interventions");

    return ref.onValue.map((queryEvent) {
      var snapshot = queryEvent.snapshot;

      return (snapshot.val() as Map<String, dynamic>).values.map((e) {
        return Intervention(
          dateTime: DateTime.now(),
          contact: e["reporter"],
          description: e["desc"],
          phone: e["phone"],
          email: e["email"],
          status: e["status"],
          adress: e["location"]);
      }).toList();
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

      return null;
    }
  }
}