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

  String pesquisa = "";

  set search(String pesquisaUsuario){
    pesquisa = pesquisaUsuario;
    notifyListeners();
  }

  List<Produto> get filtrarListaProduto{
    List<Produto> produtosFiltrados = [];
    if( pesquisa.isEmpty){
      produtosFiltrados.addAll(todosProdutos);
    }else{
      produtosFiltrados.addAll(
          todosProdutos.where((element) =>
              element.name!.toLowerCase().contains(pesquisa.toLowerCase())));
    }
    return produtosFiltrados;
  }

  Future<void> _carregarTodosProdutos()async{
    QuerySnapshot snapshotProducts = await
    firebaseFirestore.collection("products").get();

    todosProdutos = snapshotProducts.docs.map((e) => Produto.fromDocument(e)).toList();
    notifyListeners();
  }

  Produto? encontrarProdutoPorId (String id){
    try{
      return todosProdutos.firstWhere((p) => p.id == id);
    }catch(e){
      return null;
    }
  }
}