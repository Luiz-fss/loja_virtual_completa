import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_completa/models/sessao.dart';

class GerenciadorHome extends ChangeNotifier{

  GerenciadorHome(){
    _carregarSessoes();
  }

  List<Sessao> _sessoes=[];
  List<Sessao> _editingSections=[];

  List<Sessao> get sections {
    if(editing){
      return _sessoes;
    }
    return _editingSections;
  }


  bool editing = false;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<void> _carregarSessoes() async{
    firebaseFirestore.collection("home").snapshots().listen((snapshot) {
      _sessoes = [];
      for(final DocumentSnapshot documentSnapshot in snapshot.docs){
        _sessoes.add(Sessao.fromDocument(documentSnapshot));
      }
      notifyListeners();
    });
  }

  void enterEditing(){
    editing = true;
    _editingSections = _sessoes.map((s) => s.clone()).toList();
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