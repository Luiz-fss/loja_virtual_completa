import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'produto.dart';

class GerenciadorProduto extends ChangeNotifier{

  GerenciadorProduto(){
    _carregarTodosProdutos();
  }
  List<Produto> todosProdutos = [];

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  String _pesquisa = "";

  set search(String pesquisa){
    _pesquisa = pesquisa;
    notifyListeners();
  }

  List<Produto> get filtrarListaProduto{
    List<Produto> produtosFiltrados = [];
    if( _pesquisa.isEmpty){
      produtosFiltrados.addAll(todosProdutos);
    }else{
      produtosFiltrados.addAll(
          todosProdutos.where((element) =>
              element.name!.toLowerCase().contains(_pesquisa.toLowerCase())));
    }
    return produtosFiltrados;
  }

  Future<void> _carregarTodosProdutos()async{
    QuerySnapshot snapshotProducts = await
    firebaseFirestore.collection("products").get();

    todosProdutos = snapshotProducts.docs.map((e) => Produto.fromDocument(e)).toList();
    notifyListeners();
  }
}