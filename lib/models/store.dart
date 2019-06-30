import 'package:firebase/firebase.dart' as firebase;
import 'package:kakaton/models/interventions.dart';

class Store {
  final Interventions interventions = Interventions();

  bool get isAuthenticated {
    return firebase.auth().currentUser != null;
  }
}

final store = Store();