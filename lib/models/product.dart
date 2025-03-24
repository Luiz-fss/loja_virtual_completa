import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_completa/models/item_size.dart';
import 'package:uuid/uuid.dart';

class Product extends ChangeNotifier{
  String? id;
  String? name;
  String? description;
  List<String>? images;
  List<ItemSize>? sizes;
  List<dynamic>? newImages;
  ItemSize? _selectedItemSize;
  bool? deleted;

  ItemSize? get selectedSize => _selectedItemSize;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseStorage get storage => FirebaseStorage.instance;

  Reference get storageRef => storage.ref().child("products").child(id!);

  DocumentReference get  firestoreRef => firestore.doc("products/$id");

  List<String> updateImages = [];

  Product({this.id,this.description,this.name,this.sizes,this.images,this.deleted = false}){
    images = images ?? [];
    sizes = sizes ?? [];
  }

  int get totalStock{
    int stock = 0;
    for(final size in sizes!){
      stock += size.stock!;
    }
    return stock;
  }

  bool get hasStock => totalStock >  0 && !deleted!;

  set selectedSize (ItemSize? value){
    _selectedItemSize = value;
    notifyListeners();
  }


  Product.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document["name"] as String;
    description = document["description"] as String;
    images = List<String>.from(document["images"] as List<dynamic>);
    deleted = (document["deleted"] ?? false);
    sizes = (document["sizes"] as List<dynamic>)
        .map((s) => ItemSize.fromMap(s))
        .toList();

  }

  List<Map<String,dynamic>> exportSizeList(){
    return sizes!.map((size)=> size.toMap()).toList();
  }

  ItemSize? findSize (String name){
   try{
     return sizes!.firstWhere((s)=> s.name == name);
   }catch (e){
     return null;
   }
  }

  Future<void> save()async{
    _loading = true;
    notifyListeners();
    final Map<String,dynamic> data={
      "name":name,
      "deleted":deleted,
      "description":description,
      "sizes": exportSizeList()
    };

    if(id == null){
      final doc = await firestore.collection("products").add(data);
      id = doc.id;
    }else{
      await firestoreRef.update(data);
    }
    
    for (final newImage in newImages!){
      if(images!.contains(newImage)){
        updateImages.add(newImage as String);
      }else{
        final UploadTask task = storageRef.child(Uuid().v1()).putFile(newImage as File);
        final TaskSnapshot snapshot = await task;
        final String url = await snapshot.ref.getDownloadURL();
        updateImages.add(url);
      }
    }

    for(final image in images!){
      if(!newImages!.contains(image)){
        try{
          final ref = await storage.refFromURL(image);
          await ref.delete();
        }catch(e){
          debugPrint("Falha ao deletar");
        }

      }
    }
    await firestoreRef.update({"images":updateImages});

    images = updateImages;

    _loading = false;
  }


  num get basePrice {
    num lowest = double.infinity;
    for(final size in sizes!){
      if(size.price! < lowest){
        lowest = size.price!;
      }

    }
    return lowest;
  }

  Product clone (){
    return Product(
      id: id,
      name: name,
      description: description,
      images: List.from(images!),
      sizes: sizes?.map((size)=> size.clone()).toList(),
      deleted: deleted
    );
  }

  bool _loading = false;

  bool get loading => _loading;
  set loading (bool value){
    _loading = value;
    notifyListeners();
  }

  void delete(){
    firestoreRef.update({"deleted":true});
  }
}
