
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_completa/models/produto.dart';
import 'package:loja_virtual_completa/models/tamanho-item.dart';

class ProdutoCart extends ChangeNotifier {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  ProdutoCart.fromProduct(this.produto){
    productId = produto?.id!;
    quantidade = 1;
    tamanho = produto?.tamanhos.first.nome;
  }

  ProdutoCart.fromDocument(DocumentSnapshot documentSnapshot){
    id = documentSnapshot.id;
    productId = documentSnapshot["pid"] as String;
    quantidade = documentSnapshot["quantity"] as int;
    tamanho = documentSnapshot["size"] as String;
    id = documentSnapshot.id;

    firestore.doc("products/$productId").get().then((value){
      produto = Produto.fromDocument(value);
      notifyListeners();
    });
  }

  Map<String,dynamic> toCartItemMap(){
    return {
      "pid": productId,
      "quantity": quantidade,
      "size": tamanho
    };
  }

  String? productId;
  int? quantidade;
  String? tamanho;
  String? id;

  Produto? produto;

  bool get verificarEstoque{
    final tamanho = tamanhoDoItem;
    if(tamanho == null){
      return false;
    }else{
      return tamanho.stock! >= quantidade!;
    }
  }

  TamanhoItem? get tamanhoDoItem{
    if(produto == null){
      return null;
    }else {
      return produto!.encontrarTamanho(tamanho!);
    }
  }

  num? get buscarPrecoUnitario{
    if(produto==null){
      return 0;
    }else{
      return tamanhoDoItem?.preco ?? 0;
    }
  }

  bool stackable(Produto produto){
    return produto.id == productId && produto.tamanhos.first.nome == tamanho;
  }

  void incrementar(){
    quantidade = quantidade! +1;
    notifyListeners();
  }

  num get totalPrice => buscarPrecoUnitario! * quantidade!;

  void decrementar(){
    quantidade = quantidade! -1;
    notifyListeners();
  }
}