import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/order.dart';
import 'package:loja_virtual_completa/models/user.dart';

class AdminOrdersManager extends ChangeNotifier {

  UserModel? user;
  List<OrderModel> _orders = [];

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  UserModel? userFilter;

  List<OrderModel> get filteredOrders{
    List<OrderModel> output= _orders.reversed.toList();
    if(userFilter != null){
      output = output.where((o)=> o.userId == userFilter?.id).toList();
    }
    return output;
  }

  void setUserFilter(UserModel? userModel){
    userFilter = userModel;
    notifyListeners();
  }

  void updateAdmin(bool adminEnabled) {

    _orders.clear();
    _subscription?.cancel();
    if (adminEnabled) {
      _listenToOrders();
    }
  }


  void _listenToOrders() {
    _subscription =  firestore
        .collection("orders").snapshots()
        .listen((event) {
          for(final change in event.docChanges){
            switch(change.type) {
              case DocumentChangeType.added:
                _orders.add(OrderModel.fromDocument(change.doc));
                break;
              case DocumentChangeType.modified:
                final modOrder = _orders.firstWhere((o)=>o.orderId == change.doc.id);
                modOrder.updateFromDocument(change.doc);
                break;
              case DocumentChangeType.removed:
                // TODO: Handle this case.
                break;
            }
          }
      notifyListeners();
    });
  }

  StreamSubscription? _subscription;
  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}