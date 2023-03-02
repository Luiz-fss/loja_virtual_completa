import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'produto.dart';

class GerenciadorProduto extends ChangeNotifier{

  GerenciadorProduto(){
    _carregarTodosProdutos();
  }
  List<Produto> _todosProdutos = [];

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> _carregarTodosProdutos()async{
    QuerySnapshot snapshotProducts = await
    firebaseFirestore.collection("products").get();

    _todosProdutos = snapshotProducts.docs.map((e) => Produto.fromDocument(e)).toList();
    notifyListeners();
  }
}