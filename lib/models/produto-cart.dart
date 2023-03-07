import 'package:loja_virtual_completa/models/produto.dart';

class ProdutoCart {
  ProdutoCart.fromProduct(this.produto){
    productId = produto.id!;
    quantidade = 1;
    tamanho = produto.selecionarTamanho.nome!;
  }

  String? productId;
  int? quantidade;
  String? tamanho;

  Produto produto;
}