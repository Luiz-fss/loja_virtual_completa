import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_completa/models/sessao.dart';

class GerenciadorHome extends ChangeNotifier{

  GerenciadorHome(){
    _carregarSessoes();
  }

  List<Sessao> sessoes=[];

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<void> _carregarSessoes() async{
    firebaseFirestore.collection("home").snapshots().listen((snapshot) {
      sessoes.clear();
      for(final DocumentSnapshot documentSnapshot in snapshot.docs){
        sessoes.add(Sessao.fromDocument(documentSnapshot));
      }
      notifyListeners();
    });
  }
}