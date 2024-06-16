import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual_completa/models/item-sessao.dart';

class Sessao {

  String? name;
  String? type;
  List<ItemSessao>? items;

  Sessao({this.name,this.items,this.type}){items = items ?? [];}

  Sessao.fromDocument(DocumentSnapshot document){
    name = document["name"] as String?;
    type = document["type"] as String?;
    items = (document["items"] as List).map((item) => ItemSessao.fromMap(item)).toList();
  }

  Sessao clone (){
    return Sessao(
      name: name,
      type: type,
      items: items?.map((e) => e.clone()).toList()
    );
  }
}