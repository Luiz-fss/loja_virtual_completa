import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_completa/models/gerenciador-usuario.dart';
import 'package:loja_virtual_completa/models/produto-cart.dart';
import 'package:loja_virtual_completa/models/produto.dart';
import 'package:loja_virtual_completa/models/usuario-model.dart';

class GerenciadorCarrinho extends ChangeNotifier{

  List<ProdutoCart> itens = [];

  Usuario? usuario = Usuario();

  void adicionarAoCarrinho(Produto produto){
    try{
      final e = itens.firstWhere((element) => element.stackable(produto));
      e.incrementar();
    }catch(e){
      final produtoCarrinho = ProdutoCart.fromProduct(produto);
      produtoCarrinho.addListener(_atualizarItem);
      itens.add(produtoCarrinho);
      usuario?.referenciaCarrinho.add(produtoCarrinho.toCartItemMap()).then((doc) => produtoCarrinho.id = doc.id);
    }
  }

  void _atualizarItem(){
    for(final cartProduct in itens){
      if(cartProduct.quantidade == 0){
        _removerDoCarrinho(cartProduct);
      }
      _atualizarProdutoCarrinho(cartProduct);
    }
  }

  void _removerDoCarrinho(ProdutoCart cartProduct){
    itens.removeWhere((element) => element.id == cartProduct.id);
    usuario?.referenciaCarrinho.doc(cartProduct.id).delete();
    cartProduct.removeListener(_atualizarItem);
    notifyListeners();
  }

  void _atualizarProdutoCarrinho(ProdutoCart cartProduct){
    usuario?.referenciaCarrinho.doc(cartProduct.id).update(cartProduct.toCartItemMap());
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
      itens = cartSnapshot.docs.map((e) => ProdutoCart.fromDocument(e)..addListener(_atualizarItem)).toList();
    }
  }

}