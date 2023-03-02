import 'package:cloud_firestore/cloud_firestore.dart';

class Produto {

  Produto.fromDocument(DocumentSnapshot documentSnapshot){
    name = documentSnapshot["name"] as String;
    description = documentSnapshot["description"] as String;
    images = List<String>.from(documentSnapshot["images"] as List<dynamic>);
    id = documentSnapshot.id;
  }

  String? name;
  String? description;
  List<String>? images;
  String? id;

}