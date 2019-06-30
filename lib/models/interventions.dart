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
          description: "test",
          phone: "test",
          email: "test@test.com",
          status: "asdasd",
          adress: "asdasd");
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