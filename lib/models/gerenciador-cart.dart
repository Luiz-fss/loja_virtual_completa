import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loja_virtual_completa/models/address.dart';
import 'package:loja_virtual_completa/models/gerenciador-usuario.dart';
import 'package:loja_virtual_completa/models/cart-product.dart';
import 'package:loja_virtual_completa/models/product.dart';
import 'package:loja_virtual_completa/models/usuario-model.dart';
import 'package:loja_virtual_completa/services/cepaberto-services.dart';

class GerenciadorCarrinho extends ChangeNotifier{
  List<CartProduct> items = [];

  Usuario? user = Usuario();
  Address? address;

  num productsPrice = 0;
  num? deliveryPrice;
  bool _loading = false;
  bool get loading => _loading;
  set loading (bool value){
    _loading = value;
    notifyListeners();
  }
  num get totalPrice => productsPrice + (deliveryPrice ?? 0);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void updateUser(GerenciadorUsuario? gerenciadorUsuario) {
    user = gerenciadorUsuario?.usuarioAtual;
    items.clear();
    productsPrice = 0;
    removerAddress();

    if (user != null) {
      _loadCartItems();
      _loadUserAddress();
    }
  }

  Future<void> _loadUserAddress ()async{
    if(user != null && user!.address != null &&
        await calculateDelivery(user!.address!.lat!, user!.address!.long!)){
      address = user!.address;
      notifyListeners();
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

  bool get isAddressValid => address !=null && deliveryPrice != null;

  Future<void> getAddress(String cep)async{
    loading = true;
    final cepAbertoService = CepAbertoServices();
    try{
     final cepAberto =  await cepAbertoService.getAddressFromCep(cep);
     if(cepAberto != null){
      address = Address(
        street: cepAberto.logradouro,
         district: cepAberto.bairro,
         state: cepAberto.estado?.sigla,
         city: cepAberto.cidade?.nome,
         lat: cepAberto.latitude,
         long: cepAberto.longitude,
         zipCode: cepAberto.cep
       );
     }
     loading = false;

    }catch(e){
      loading = false;
      return Future.error("CEP Inválido");
    }


  }

  void removerAddress(){
    address = null;
    deliveryPrice = null;
    notifyListeners();
  }

  Future<void> setAddress (Address address)async{
    loading = true;
    this.address = address;
    if(await calculateDelivery(address.lat ?? 0 , address.long ?? 0)){
      user?.setAddress(address);
      loading = false;
    }else{
      loading = false;
      return Future.error("Endereço fora do raio de entrga :(");
    }
  }

  Future<bool> calculateDelivery(double lat, double long)async{
    final DocumentSnapshot doc = await firestore.doc("aux/delivery").get();

    final data = doc.data() as Map<String,dynamic>;
    final latStore = data["lat"] as double;
    final longStore = data["long"] as double;
    final maxKm = data["maxKm"] as num;
    final km = data["km"] as num;
    final base = data["base"] as num;

    double dis =  Geolocator.distanceBetween(latStore, longStore, lat, long);
    dis /= 1000.0;

    if(dis > maxKm){
      return false;
    }
    deliveryPrice = base + dis * km;
    return true;
  }
}