import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual_completa/models/gerenciador-usuario.dart';
import 'package:loja_virtual_completa/models/produto-cart.dart';
import 'package:loja_virtual_completa/models/produto.dart';
import 'package:loja_virtual_completa/models/usuario-model.dart';

class GerenciadorCarrinho {

  List<ProdutoCart> itens = [];

  Usuario? usuario = Usuario();

  void adicionarAoCarrinho(Produto produto){
    itens.add(ProdutoCart.fromProduct(produto));
  }

  void updateUser(GerenciadorUsuario? gerenciadorUsuario){
    usuario = gerenciadorUsuario?.usuarioAtual;
    itens.clear();

    if(usuario != null){
      _carregarItensDoCarrinho();
    }
  }

  Future<void> _carregarItensDoCarrinho()async{
    final QuerySnapshot? cartSnapshot = await usuario?.referenciaCarrinho.get();
    if(cartSnapshot != null){
      itens = cartSnapshot.docs.map((e) => ProdutoCart.fromDocument(e)).toList() as List<ProdutoCart>;
    }
  }

}