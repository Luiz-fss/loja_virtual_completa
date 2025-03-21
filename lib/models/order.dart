import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual_completa/models/address.dart';
import 'package:loja_virtual_completa/models/cart_manager.dart';
import 'package:loja_virtual_completa/models/cart_product.dart';
import 'package:loja_virtual_completa/models/product.dart';


enum Status {canceled, preparing, transporting, delivered}

class OrderModel {
  List<CartProduct>? items;
  num? price;
  String? orderId;
  String? userId;
  Address? address;
  Timestamp? date;
  Status? status;

  OrderModel.fromCartManager(CartManager cartManager){
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userId = cartManager.user?.id;
    address = cartManager.address;
    status = Status.preparing;
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> save()async{
    firestore.collection("orders").doc(orderId).set({
      "items":items?.map((e)=>e.toOrderItemMap()).toList(),
      "price":price,
      "user":userId,
      "address": address?.toMap(),
      "status":status?.index,
      "date": Timestamp.now()
    });
  }

  OrderModel.fromDocument(DocumentSnapshot doc){
    orderId = doc.id;
    price = doc["price"];
    userId = doc["user"] as String;
    address = Address.fromMap(doc["address"] as Map<String,dynamic>);
    status = Status.values[doc["status"] as int];
    //date = doc["date"] as Timestamp;
    items = (doc["items"] as List<dynamic>).map((e)=>CartProduct.fromMap(e)).toList();
  }

  String get formattedId => "#${orderId?.padLeft(6,"0")}";

  String get statusText=> getStatus(status??Status.canceled);
  static String getStatus(Status status){
    switch(status){

      case Status.canceled:
        return "Cancelado";
      case Status.preparing:
       return "Em preparação";
      case Status.transporting:
        return "Em transporte";
      case Status.delivered:
       return "Entregue";
    }
  }

  Function() get back {
    return status!.index >= Status.transporting.index ?
    (){
      status = Status.values[status!.index -1];
      firestoreRef.update({"status":status!.index});
    }: (){};
  }

  Function() get advanced {
    return status!.index <= Status.transporting.index ?
        (){
      status = Status.values[status!.index +1];
      firestoreRef.update({"status":status!.index});
    }: (){};
  }

  void updateFromDocument(DocumentSnapshot doc){
    status = Status.values[doc["status"]];
  }

  void cancel(){
    status = Status.canceled;
    firestoreRef.update({"status":status!.index});
  }

  DocumentReference get firestoreRef => firestore.collection("orders").doc(orderId);
}