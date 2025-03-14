import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loja_virtual_completa/models/address.dart';
import 'package:loja_virtual_completa/models/cart_product.dart';
import 'package:loja_virtual_completa/models/product.dart';
import 'package:loja_virtual_completa/models/user.dart';
import 'package:loja_virtual_completa/models/user_manager.dart';
import 'package:loja_virtual_completa/services/cepaberto-services.dart';

class CartManager extends ChangeNotifier {
  List<CartProduct> items = [];

  UserModel? user;

  Address? address;

  num productsPrice = 0;

  num get totalPrice =>productsPrice + (deliveryPrice ?? 0);

  bool get isAddressValid => address != null && deliveryPrice != null;

  bool _loading = false;

  bool get loading => _loading;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  num? deliveryPrice;

  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  void updateUser(UserManager userManager) {
    user = userManager.user;
    items.clear();
    removeAddress();

    if (user != null) {
      _loadCartItems();
      _loadUserAddress();
    }
  }

  Future<void> _loadUserAddress()async{
    if(user != null || user?.address != null ){
      await calculateDelivery(user!.address!.lat!, user!.address!.long!);
      address = user!.address;
      notifyListeners();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot? cartSnap = await user?.cartReference.get();
    if (cartSnap != null) {
      items = cartSnap!.docs
          .map((d) => CartProduct.fromDocument(d)..addListener(_onItemUpdated))
          .toList();
    }
  }

  void addToCart(Product product) {
    try {
      final e = items.firstWhere((p) => p.stackable(product));
      e.increment();
    } catch (e) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdated);
      items.add(cartProduct);
      user?.cartReference
          .add(cartProduct.toCartItemMap())
          .then((doc) => cartProduct.id = doc.id);
      _onItemUpdated();
    }
    notifyListeners();
  }

  void removeOfCart(CartProduct cartProduct) {
    items.removeWhere((p) => p.id == cartProduct.id);
    user?.cartReference.doc(cartProduct.id).delete();
    cartProduct.removeListener(_onItemUpdated);
    notifyListeners();
  }

  void _onItemUpdated() {
    productsPrice = 0;
    for (int i = 0; i < items.length; i++) {
      final cartProduct = items[i];
      if (cartProduct.quantity == 0) {
        removeOfCart(cartProduct);
        i--;
        continue;
      }

      productsPrice += cartProduct.totalPrice;
      _updateCartProduct(cartProduct);
    }
    notifyListeners();
  }

  void _updateCartProduct(CartProduct cartProduct) {
    if(cartProduct.id != null){
      user?.cartReference.doc(cartProduct.id).update(cartProduct.toCartItemMap());
    }

  }

  bool get isCartValid {
    for (final cartProduct in items) {
      if (!cartProduct.hasStock) {
        return false;
      }
    }
    return true;
  }

  Future<void> getAddress(String cep)async{
    loading = true;
    final cepAbertoService = CepAbertoServices();
    try{
      final cepAbertoAddress = await cepAbertoService.getAddressFromCep(cep);
      if(cepAbertoAddress != null){
        address = Address(
            street: cepAbertoAddress.logradouro,
            district: cepAbertoAddress.bairro,
            state: cepAbertoAddress.estado?.sigla,
            city: cepAbertoAddress.cidade?.nome,
            lat: cepAbertoAddress.latitude,
            long: cepAbertoAddress.longitude,
            zipCode: cepAbertoAddress.cep
        );

      }
      loading = false;
    }catch(e){
      loading = false;
     return Future.error("CEP inválido");
    }
  }

  void removeAddress(){
    address = null;
    deliveryPrice = null;
    notifyListeners();
  }

  Future<void> setAddress(Address address)async{
    loading = true;
    this.address = address;
   if(await calculateDelivery(address.lat??0, address.long??0)){
     user?.setAddress(address);

     loading = false;
   }else{
     loading = false;
     return Future.error("Endereço fora do raio de entrega :(");
   }

  }

  Future<bool> calculateDelivery(double lat,double long)async{
    final DocumentSnapshot doc = await firestore.doc("aux/delivery").get();
    final double latStore = doc["lat"];
    final double longStore = doc["long"];
    final maxKm = doc["maxKm"]as num;
    final base = doc["base"]as num;
    final km = doc["km"] as num;

    double dis = Geolocator.distanceBetween(latStore, longStore, lat, long);
    dis = dis / 1000;

    if(dis > maxKm){
     return false;
    }

    deliveryPrice = base + dis * km;
    return true;
  }


}
