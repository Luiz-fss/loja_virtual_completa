import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_completa/models/tamanho-item.dart';
import 'package:loja_virtual_completa/telas/produtos/item-tamanho.dart';

class Produto extends ChangeNotifier{

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


}