import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_completa/models/order.dart';
import 'package:loja_virtual_completa/models/user.dart';
import 'package:loja_virtual_completa/models/user_manager.dart';

class OrdersManager extends ChangeNotifier {
  UserModel? user;
  List<OrderModel> orders = [];

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void updateUser(UserModel? userManager) {
    this.user = userManager;
    orders.clear();
    _subscription?.cancel();
    if (user != null) {
      _listenToOrders();
    }
  }

  void _listenToOrders() {
   _subscription =  firestore
        .collection("orders")
        .where("user", isEqualTo: user?.id)
        .snapshots()
        .listen((event) {
      orders.clear();
      for(final doc in event.docs){
        orders.add(OrderModel.fromDocument(doc));
      }
      notifyListeners();
      print(orders);
    });
  }

  StreamSubscription? _subscription;
  @override
  void dispose() {
   _subscription?.cancel();
    super.dispose();
  }
}
