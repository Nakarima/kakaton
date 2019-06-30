import 'package:kakaton/models/intervention.dart';

class Comment {
  String key;
  Intervention intervention;
  DateTime dateTime;
  String description;
  String author;
  String authorEmail;

  Comment({
    this.intervention,
    this.key,
    this.dateTime:null, 
    this.description:null});


}