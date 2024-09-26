import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_completa/models/item-size.dart';
import 'package:loja_virtual_completa/telas/produtos/item-tamanho.dart';
import 'package:uuid/uuid.dart';

class Product extends ChangeNotifier{

  Product({this.id,this.description,this.name,this.images, this.sizes}){
    images = images ?? [];
    sizes = sizes ?? [];
  }

  Product.fromDocument(DocumentSnapshot documentSnapshot){
    name = documentSnapshot["name"] as String;
    description = documentSnapshot["description"] as String;
    images = List<String>.from(documentSnapshot["images"] as List<dynamic>);
    id = documentSnapshot.id;
    sizes = (documentSnapshot["sizes"] as
    List<dynamic>).map((e) => ItemSize.fromMap(e)).toList();

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

  List<ItemSize>? sizes;

  ItemSize? _selectedSize = ItemSize();

  ItemSize get selectedSize  => _selectedSize!;
  set selectedSize(ItemSize valor){
    _selectedSize = valor;
    notifyListeners();
  }

  num get totalStock{
    num stock = 0;
    for(final tamanho in sizes ?? []){
      stock = stock+ tamanho.stock!;
    }
    return stock;
  }

  num get basePrice{
    num lowest = double.infinity;
    for(final size in sizes ?? []){
      if(size.price! < lowest && size.hasStock){
        lowest = size.price!;
      }
    }
    return lowest;
  }

  bool get hasStock {
    return totalStock >0;}

  ItemSize? findSize(String nome){
    try {
      return sizes?.firstWhere((s) => s.name == nome);
    }catch(e){
      return null;
    }
  }

  Product clone (){
    return Product(
      id: id,
      name: name,
      description: description,
      images: List.from(images!),
      sizes: sizes?.map((e) => e.clone()).toList()
    );
  }

  List<Map<String,dynamic>> exportSizeList (){
    return sizes!.map((size) => size.toMap()).toList();
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
        final url = await task.ref.getDownloadURL() as String;
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