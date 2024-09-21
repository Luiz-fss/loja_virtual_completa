import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_completa/models/item-sessao.dart';
import 'package:uuid/uuid.dart';

class Sessao extends ChangeNotifier{

  String? name;
  String? type;
  String? id;
  List<ItemSessao>? items;
  List<ItemSessao>? originalItems;
  String? _error = "";

  String get error => _error ?? "";
  set error(String? value){
    _error = value;
    notifyListeners();
  }

  Sessao({this.name,this.items,this.type,this.id}){items = items ?? [];originalItems = List.from(items ?? []);}

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
    id = document.id;
    items = (document["items"] as List).map((item) => ItemSessao.fromMap(item)).toList();
  }

  Sessao clone (){
    return Sessao(
      name: name,
      id: id,
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

  Future<void> save()async{
    final Map<String,dynamic> data={
      "name": name,
      "type":type,
      //"items": items?.map((item) => item.toMap()).toList();
    };
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    if(id==null){

      final doc = await firestore.collection("home").add(data);
      id = doc.id;
    }else{
      DocumentReference getCurrentDoc = firestore.doc("products/$id");
      await getCurrentDoc.update(data);
    }

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageRef = storage.ref().child("home").child(id!);
    for(final item in items ?? []){
      if(item.image is File){
        final task = await storageRef.child(Uuid().v1()).putFile(item.image as File);
        final url = await task.ref.getDownloadURL() as String;
        item.image = url;
      }
    }

    for(final original in originalItems ?? []){
      if(items != null && !items!.contains(original)){
        try{
          final ref = await storage.refFromURL(original.image as String);
          await ref.delete();
        }catch(e){
          debugPrintStack();
        }
      }
    }

    final Map<String,dynamic> itemsData = {
      "name":name,
      "type":type,
      "items": items?.map((e) => e.toMap()).toList()
    };

    await firestore.collection("home").doc(id!).update(itemsData);
  }
}