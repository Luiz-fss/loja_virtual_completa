
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_completa/models/item_size.dart';
import 'package:loja_virtual_completa/models/product.dart';

class CartProduct extends ChangeNotifier{

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? id;
  String? productId;
  int? quantity;
  String? size;

  Product? product;

  CartProduct.fromProduct(this.product){
    productId =product?.id;
    quantity = 1;
    size = product?.selectedSize?.name ?? "";
  }

  CartProduct.fromDocument(DocumentSnapshot document){
    id = document.id;
    productId = document["pid"];
    quantity = document["quantity"];
    size = document["size"];
    
    firestore.doc("products/${productId}").get().then((doc){
      product = Product.fromDocument(doc);
      notifyListeners();
    });
  }

  ItemSize? get itemSize{
    if(product == null){
      return null;
    }
    return product!.findSize(size ?? "");
  }

  num get unityPrice {
    if(product == null){
      return 0;
    }
    return itemSize?.price ?? 0;
  }

  Map<String, dynamic> toCartItemMap(){
    return {
      "pid": productId,
      "quantity": quantity,
      "size": size
    };
  }

  bool stackable (Product product){
    return product.id == productId && product.selectedSize?.name == size;
  }

  void increment(){
    quantity = quantity! + 1;
    notifyListeners();
  }

  void decrement(){
    quantity = quantity! - 1;
    notifyListeners();
  }

  bool get hasStock{
    final size = itemSize;
    if(size ==null){
      return false;
    }
    return size.stock! >= quantity!;
  }

  num get totalPrice => unityPrice * (quantity ?? 0);
}