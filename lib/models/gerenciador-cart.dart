import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_completa/models/gerenciador-usuario.dart';
import 'package:loja_virtual_completa/models/produto-cart.dart';
import 'package:loja_virtual_completa/models/produto.dart';
import 'package:loja_virtual_completa/models/usuario-model.dart';

class GerenciadorCarrinho extends ChangeNotifier{
  List<ProdutoCart> itens = [];

  Usuario? usuario = Usuario();

  num precoProdutos = 0;

  void adicionarAoCarrinho(Produto produto) {
    try {
      final e = itens.firstWhere((element) => element.stackable(produto));
      e.incrementar();
    } catch (e) {
      final produtoCarrinho = ProdutoCart.fromProduct(produto);
      produtoCarrinho.addListener(_atualizarItem);
      itens.add(produtoCarrinho);
      usuario?.referenciaCarrinho
          .add(produtoCarrinho.toCartItemMap())
          .then((doc) => produtoCarrinho.id = doc.id);
      _atualizarItem();
    }
  }

  void _atualizarItem() {
    precoProdutos = 0;
    for (int i =0; i<itens.length; i++) {
      final cartProduct = itens[i];
      if (cartProduct.quantidade == 0) {
        removerDoCarrinho(cartProduct);
        i--;
        continue;

      }
      precoProdutos += cartProduct.totalPrice;
      _atualizarProdutoCarrinho(cartProduct);
    }
    notifyListeners();
  }

  void removerDoCarrinho(ProdutoCart produtoCart) {
    itens.removeWhere((p) => p.id == produtoCart.id);
    usuario?.referenciaCarrinho.doc(produtoCart.id).delete();
    produtoCart.removeListener(_atualizarItem);
    notifyListeners();
  }

  void _atualizarProdutoCarrinho(ProdutoCart? produtoCart) {
    if(produtoCart != null){
      usuario?.referenciaCarrinho
          .doc(produtoCart.id)
          .update(produtoCart.toCartItemMap());
    }

  }

  void updateUser(GerenciadorUsuario? gerenciadorUsuario) {
    usuario = gerenciadorUsuario?.usuarioAtual;
    itens.clear();

    if (usuario != null) {
      _carregarItensDoCarrinho();
    }
  }

  Future<void> _carregarItensDoCarrinho() async {
    final QuerySnapshot? cartSnapshot = await usuario?.referenciaCarrinho.get();
    if (cartSnapshot != null) {
      itens = cartSnapshot.docs
          .map((e) => ProdutoCart.fromDocument(e)..addListener(_atualizarItem))
          .toList();
    }

  }

  bool get carrinhoValido {
    bool carrinhoValido = true;
    for (final cartProduct in itens) {
      if (!cartProduct.verificarEstoque) {
        carrinhoValido = false;
      }
    }
    return carrinhoValido;
  }
}