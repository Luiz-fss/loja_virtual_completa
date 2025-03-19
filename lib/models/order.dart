import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual_completa/models/address.dart';
import 'package:loja_virtual_completa/models/cart_manager.dart';
import 'package:loja_virtual_completa/models/cart_product.dart';
import 'package:loja_virtual_completa/models/product.dart';

class OrderModel {
  List<CartProduct>? items;
  num? price;
  String? orderId;
  String? userId;
  Address? address;
  Timestamp? date;

  OrderModel.fromCartManager(CartManager cartManager){
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userId = cartManager.user?.id;
    address = cartManager.address;
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> save()async{
    firestore.collection("orders").doc(orderId).set({
      "items":items?.map((e)=>e.toOrderItemMap()).toList(),
      "price":price,
      "user":userId,
      "address": address?.toMap()
    });
  }
}