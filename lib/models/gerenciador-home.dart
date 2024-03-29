import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_completa/models/sessao.dart';

class GerenciadorHome extends ChangeNotifier{

  GerenciadorHome(){
    _carregarSessoes();
  }

  List<Sessao> sessoes=[];

  bool editing = false;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<void> _carregarSessoes() async{
    firebaseFirestore.collection("home").snapshots().listen((snapshot) {
      sessoes = [];
      for(final DocumentSnapshot documentSnapshot in snapshot.docs){
        sessoes.add(Sessao.fromDocument(documentSnapshot));
      }
      notifyListeners();
    });
  }

  void enterEditing(){
    editing = true;
    notifyListeners();
  }

  void saveEditing(){
    editing = false;
    notifyListeners();
  }

  void descardEditing(){
    editing = false;
    notifyListeners();
  }
}