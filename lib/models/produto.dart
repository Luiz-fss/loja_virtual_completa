import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual_completa/models/tamanho-item.dart';

class Produto {

  Produto.fromDocument(DocumentSnapshot documentSnapshot){
    name = documentSnapshot["name"] as String;
    description = documentSnapshot["description"] as String;
    images = List<String>.from(documentSnapshot["images"] as List<dynamic>);
    id = documentSnapshot.id;
    tamanhos = (documentSnapshot["sizes"] as
    List<dynamic>).map((e) => TamanhoItem.fromMap(e)).toList();

  }

  String? name;
  String? description;
  List<String>? images;
  String? id;
  List<TamanhoItem>? tamanhos;

}