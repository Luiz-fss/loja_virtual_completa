import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_completa/models/user.dart';
import 'package:loja_virtual_completa/models/user_manager.dart';

class AdminUsersManager extends ChangeNotifier{

  List<UserModel> users = [];

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  StreamSubscription? _subscription;

  List<String> get names => users.map((e)=> e.name!).toList();

  void updateUser(UserManager userManager){
    _subscription?.cancel();
    if(userManager.adminEnable){
      _listenToUsers();
    }else{
      users.clear();

      notifyListeners();
    }
  }

  Future<void> _listenToUsers()async{
    _subscription = firestore.collection("users").snapshots().listen((snapshot){
      users = snapshot.docs.map((e)=> UserModel.fromDocument(e)).toList();
      users.sort((a,b)=> a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
      notifyListeners();
    });
  }

  @override
  void dispose(){
    _subscription?.cancel();
    super.dispose();
  }

}