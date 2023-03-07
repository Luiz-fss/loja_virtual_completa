import 'package:loja_virtual_completa/models/produto.dart';
import 'package:loja_virtual_completa/models/tamanho-item.dart';

class ProdutoCart {
  ProdutoCart.fromProduct(this.produto){
    productId = produto.id!;
    quantidade = 1;
    tamanho = produto.tamanhos.first.nome;
  }

  String? productId;
  int? quantidade;
  String? tamanho;

  Produto produto;

  TamanhoItem? get tamanhoDoItem{
    if(produto == null){
      return null;
    }else {
      return produto.encontrarTamanho(tamanho!);
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