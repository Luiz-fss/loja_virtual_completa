import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_completa/models/item-sessao.dart';

class Sessao extends ChangeNotifier{

  String? name;
  String? type;
  List<ItemSessao>? items;
  String? _error = "";

  String get error => _error ?? "";
  set error(String? value){
    _error = value;
    notifyListeners();
  }

  Sessao({this.name,this.items,this.type}){items = items ?? [];}

  void addItem(ItemSessao item){
    items?.add(item);
    notifyListeners();
  }

  void removeItem(ItemSessao item){
    items?.remove(item);
    notifyListeners();
  }

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

  bool valid(){
    if(name == null || name!.isEmpty){
      error = "Título inválido";
    }else if(items == null || items!.isEmpty){
      error = "Insira ao menos uma imagem";
    }else{
      error = null;
    }
    return error == null;
  }
}