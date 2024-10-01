import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_completa/models/gerenciador-usuario.dart';
import 'package:loja_virtual_completa/models/cart-product.dart';
import 'package:loja_virtual_completa/models/product.dart';
import 'package:loja_virtual_completa/models/usuario-model.dart';
import 'package:loja_virtual_completa/services/cepaberto-services.dart';

class GerenciadorCarrinho extends ChangeNotifier{
  List<CartProduct> items = [];

  Usuario? user = Usuario();

  num productsPrice = 0;
  num get totalPrice => productsPrice;

  void updateUser(GerenciadorUsuario? gerenciadorUsuario) {
    user = gerenciadorUsuario?.usuarioAtual;
    items.clear();

    if (user != null) {
      _loadCartItems();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot? cartSnapshot = await user?.cartReference.get();
    if (cartSnapshot != null) {
      items = cartSnapshot.docs
          .map((e) => CartProduct.fromDocument(e)..addListener(_onItemUpdated))
          .toList();
    }
  }


  void addToCart(Product produto) {
    try {
      final e = items.firstWhere((element) => element.stackable(produto));
      e.increment();
    } catch (e) {
      final produtoCarrinho = CartProduct.fromProduct(produto);
      produtoCarrinho.addListener(_onItemUpdated);
      items.add(produtoCarrinho);
      user?.cartReference
          .add(produtoCarrinho.toCartItemMap())
          .then((doc) => produtoCarrinho.id = doc.id);
      _onItemUpdated();
    }
    notifyListeners();
  }


  void removerOfCart(CartProduct produtoCart) {
    items.removeWhere((p) => p.id == produtoCart.id);
    user?.cartReference.doc(produtoCart.id).delete();
    produtoCart.removeListener(_onItemUpdated);
    notifyListeners();
  }

  void clear() {
    for(final cartProduct in items){
      user!.cartReference.doc(cartProduct.id).delete();
    }
    items.clear();
    notifyListeners();
  }

  void _onItemUpdated() {
    productsPrice = 0.0;
    for (int i =0; i<items.length; i++) {
      final cartProduct = items[i];
      if (cartProduct.quantity == 0) {
        removerOfCart(cartProduct);
        i--;
        continue;

      }
      productsPrice += cartProduct.totalPrice;
      _updateCartProduct(cartProduct);
    }
    notifyListeners();
  }


  void _updateCartProduct(CartProduct? produtoCart) {
    if(produtoCart != null){
      user?.cartReference
          .doc(produtoCart.id)
          .update(produtoCart.toCartItemMap());
    }

  }
  bool get isCartValid {
    for(final cartProduct in items){
      if(!cartProduct.hasStock) return false;
    }
    return true;
  }

  Future<void> getAddress(String cep)async{
    final cepAbertoService = CepAbertoServices();
    try{
      await cepAbertoService.getAddressFromCep(cep);
    }catch(e){

    }

  }
}