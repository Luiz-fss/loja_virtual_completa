import 'package:loja_virtual_completa/models/produto-cart.dart';
import 'package:loja_virtual_completa/models/produto.dart';

class GerenciadorCarrinho {

  List<ProdutoCart> itens = [];

  void adicionarAoCarrinho(Produto produto){
    itens.add(ProdutoCart.fromProduct(produto));
  }
}