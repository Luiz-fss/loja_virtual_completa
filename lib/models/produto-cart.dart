import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual_completa/models/produto.dart';
import 'package:loja_virtual_completa/models/tamanho-item.dart';

class ProdutoCart {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  ProdutoCart.fromProduct(this.produto){
    productId = produto?.id!;
    quantidade = 1;
    tamanho = produto?.tamanhos.first.nome;
  }

  ProdutoCart.fromDocument(DocumentSnapshot documentSnapshot){
    productId = documentSnapshot["pid"] as String;
    quantidade = documentSnapshot["quantity"] as int;
    tamanho = documentSnapshot["size"] as String;

    firestore.collection("products/$productId").get().then((value) => (){
      return produto = Produto.fromDocument(documentSnapshot);
    });
  }

  String? productId;
  int? quantidade;
  String? tamanho;

  Produto? produto;

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
}