
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_completa/models/produto.dart';
import 'package:loja_virtual_completa/models/item-size.dart';

class CartProduct extends ChangeNotifier {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CartProduct.fromProduct(this._product){
    productId = product?.id!;
    quantity = 1;
    size = product?.selectedSize.name;
  }

  CartProduct.fromDocument(DocumentSnapshot documentSnapshot){
    id = documentSnapshot.id;
    productId = documentSnapshot["pid"] as String;
    quantity = documentSnapshot["quantity"] as int;
    size = documentSnapshot["size"] as String;
    id = documentSnapshot.id;

    firestore.doc("products/$productId").get().then((value){
      product = Produto.fromDocument(value);
      notifyListeners();
    });
  }

  CartProduct.fromMap(Map<String, dynamic> map){
    productId = map['pid'] as String;
    quantity = map['quantity'] as int;
    size = map['size'] as String;
    fixedPrice = map['fixedPrice'] as num;

    firestore.doc("products/$productId").get().then((value){
      product = Produto.fromDocument(value);
    });
  }


  String? id;
  String? productId;
  int? quantity;
  String? size;
  num? fixedPrice;

  Produto? _product;
  Produto? get product => _product;
  set product(Produto? value){
    _product = value;
    notifyListeners();
  }


  ItemSize? get itemSize{
    if(product == null){
      return null;
    }else {
      return product!.findSize(size ?? "");
    }
  }

  num? get unitPrice{
    if(product==null){
      return 0;
    }else{
      return itemSize?.price ?? 0;
    }
  }

  num get totalPrice => unitPrice! * quantity!;

  Map<String,dynamic> toCartItemMap(){
    return {
      "pid": productId,
      "quantity": quantity,
      "size": size
    };
  }

  bool stackable(Produto produto){
    return produto.id == productId && produto.selectedSize.name == size;
  }

  void increment(){
    quantity = quantity! +1;
    notifyListeners();
  }

  void decrement(){
    quantity = quantity! -1;
    notifyListeners();
  }

  bool get hasStock{
    final size = itemSize;
    if(size == null){
      return false;
    }else{
      return size.stock! >= quantity!;
    }
  }

}