import 'package:firebase/firebase.dart' as firebase;

class Interventions {
  Interventions() {
    firebase.database().ref("interventions").onChildAdded.listen((e) {
      print("got event!");
      print(e.snapshot.toJson());  
    });
  }

  void add() async {
    print("calling createEmptyReport...");

    try {
      final result = 
        await firebase.functions().httpsCallable('createEmptyReport').call({});

      print(result.data);
    } catch (e) {
      print(e);
    }
  }
}