import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'product.dart';

class GerenciadorProduto extends ChangeNotifier{

  GerenciadorProduto(){
    _carregarTodosProdutos();
  }
  List<Product> todosProdutos = [];

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  String pesquisa = "";

  set search(String pesquisaUsuario){
    pesquisa = pesquisaUsuario;
    notifyListeners();
  }

  List<Product> get filtrarListaProduto{
    List<Product> produtosFiltrados = [];
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

    todosProdutos = snapshotProducts.docs.map((e) => Product.fromDocument(e)).toList();
    notifyListeners();
  }

  Product? encontrarProdutoPorId (String id){
    try{
      return todosProdutos.firstWhere((p) => p.id == id);
    }catch(e){
      return null;
    }
  }

  void update (Product product){
    todosProdutos.retainWhere((element) => element.id == product.id);
    todosProdutos.add(product);
    notifyListeners();
  }
}