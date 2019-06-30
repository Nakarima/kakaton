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
          contact: "test",
          description: e["desc"],
          phone: e["phone"],
          email: e["email"],
          status: e["status"],
          adress: e["location"]);
      }).toList();
    });
  }

  Future<Intervention> add() async {
    try {
      final result = 
        await firebase.functions().httpsCallable('createEmptyReport').call({});

      return null;
    } catch (e) {
      print(e);
    
      return null;
    }
  }
}