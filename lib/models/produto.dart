import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_completa/models/tamanho-item.dart';
import 'package:loja_virtual_completa/telas/produtos/item-tamanho.dart';
import 'package:uuid/uuid.dart';

class Produto extends ChangeNotifier{

  Produto({this.id,this.description,this.name,this.images,required this.tamanhos}){
    images = images ?? [];
    tamanhos = tamanhos ?? [];
  }

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
  bool itemSelecionado = false;
  List<dynamic>? newImages;

  bool _loading = false;
  bool get loading => _loading;
  set loading (bool value){
    _loading = value;
    notifyListeners();
  }


  marcarItemSelecionado(bool valor){
    itemSelecionado = valor;
    notifyListeners();
  }

  List<TamanhoItem> tamanhos = [];

  TamanhoItem? _tamanhoSelecionado;

  TamanhoItem get selecionarTamanho  => _tamanhoSelecionado!;
  set selecionarTamanho(TamanhoItem valor){
    _tamanhoSelecionado = valor;
    notifyListeners();
  }

  int get totalStock{
    int stock = 0;
    for(final tamanho in tamanhos){
      stock = stock+ tamanho.stock!;
    }
    return stock;
  }

  num get basePrice{
    num lowest = double.infinity;
    for(final size in tamanhos){
      if(size.preco! < lowest && size.temStock){
        lowest = size.preco!;
      }
    }
    return lowest;
  }

  bool get temStock {
    return totalStock >0;}

  TamanhoItem? encontrarTamanho(String nome){
    try {
      for(int i =0; i < tamanhos.length;i++){
        if(tamanhos[i].nome == nome){
          return tamanhos[i];
        }
      }
    }catch(e){
      return null;
    }
  }

  Produto clone (){
    return Produto(
      id: id,
      name: name,
      description: description,
      images: List.from(images!),
      tamanhos: tamanhos.map((e) => e.clone()).toList()
    );
  }

  List<Map<String,dynamic>> exportSizeList (){
    return tamanhos.map((size) => size.toMap()).toList();
  }

  Future<void> save ()async{
    _loading = true;
    final Map<String,dynamic> data = {
      "name":name,
      "description": description,
      "sizes": exportSizeList()
    };

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageRef = storage.ref().child("products").child(id!);
    if(id == null){
      final doc = await firestore.collection("products").add(data);
      id = doc.id;
    }else{
      DocumentReference getCurrentDoc = firestore.doc("products/$id");
      await getCurrentDoc.update(data);
    }

    List<String> listUpdateImages = [];
    for(final newImage in newImages ?? []){
      if(images != null && images!.contains(newImage)){
        listUpdateImages.add(newImage as String);
      }else{
        final task = await storageRef.child(Uuid().v1()).putFile(newImage as File);
        final url = await task.ref.getDownloadURL();
        listUpdateImages.add(url);
      }
    }

    for(final image in images ?? []){
      if(newImages != null && !newImages!.contains(image)){
        try{
          final ref = await storage.refFromURL(image);
          await ref.delete();
        }catch(e){
          debugPrintStack();
        }
      }
    }

    await firestore.collection("products").doc(id!).update({"images":listUpdateImages});
    images = listUpdateImages;
    _loading = false;
  }

}