import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_completa/models/store.dart';

class StoresManager extends ChangeNotifier{

  StoresManager(){
    _loadStoreList();
    _startTimer();
  }

  List<Store>? stores = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> _loadStoreList()async{
    final snapshot = await firestore.collection("stores").get();
    stores = snapshot.docs.map((e)=>Store.fromDocument(e)).toList();
    notifyListeners();
  }

  void _startTimer(){
    _timer = Timer.periodic(Duration(minutes: 1), (timer){
      _checkOpening();
    });
  }

  void _checkOpening(){
    for(final store in stores!){
      store.updateStatus();
      notifyListeners();
    }
  }

  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

}