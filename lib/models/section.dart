import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_completa/models/section_item.dart';
import 'package:uuid/uuid.dart';

class Section extends ChangeNotifier{


  String? name;
  String? type;
  List<SectionItem>? items;
  String? id;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentReference get firestoreRef => firestore.doc("home/${id}");

  List<SectionItem>? originalItems;

  FirebaseStorage get storage => FirebaseStorage.instance;

  Reference get storageRef => storage.ref().child("home").child(id!);

  Section.fromDocument(DocumentSnapshot document){
    name = document["name"];
    type = document["type"];
    id = document.id;
    items = (document["items"] as List).map((i)=> SectionItem.fromMap(i)).toList();
    print(items);
  }

  Section({this.name,this.type,this.id,this.items}){
    items = items ?? [];
    originalItems = List.from(items!);
  }

  Section clone(){
    return Section(
      name: name,
      items: items?.map((e)=>e.clone()).toList(),
      type: type,
      id: id
    );
  }

  void addItem (SectionItem item){
    items!.add(item);
    notifyListeners();
  }

  void removeItem(SectionItem item){
    items!.remove(item);
    notifyListeners();
  }

  String? _error;
  String? get error => _error;
  set error(String? value){
    _error = value;
    notifyListeners();
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


  Future<void>save(int pos)async{
    final Map<String,dynamic> data = {
      "name":name,
      "type":type,
      "pos":pos
    };

    if(id == null){
      final doc = await firestore.collection("home").add(data);
      id = doc.id;
    }else{
      await firestoreRef.update(data);
    }

    for(final item in items!){
      if(item.image is File){
        final UploadTask task = storageRef.child(Uuid().v1()).putFile(item.image as File);
        final TaskSnapshot snapshot = await task;
        final String url = await snapshot.ref.getDownloadURL();
        item.image = url;
      }
    }

    for(final original in originalItems!){
      if(!items!.contains(original)){
        try{
          final ref = await storage.refFromURL(original.image as String);
          await ref.delete();
        }catch(e){
          debugPrint("Falha ao deletar");
        }
      }
    }

    final Map<String,dynamic> itemsData = {
      "items":items!.map((e)=>e.toMap()).toList()
    };

    await firestoreRef.update(itemsData);

  }

  Future<void> delete()async{
    await firestoreRef.delete();
    for(final item in items!){
     try{
       final ref =  storage.refFromURL(item.image as String);
       await ref.delete();
     }catch(e){
       //ignore
     }
    }
  }
}