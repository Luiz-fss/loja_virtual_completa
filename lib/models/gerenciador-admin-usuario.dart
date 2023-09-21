import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_completa/models/gerenciador-usuario.dart';
import 'package:loja_virtual_completa/models/usuario-model.dart';

class GerenciadorAdminUsuario extends ChangeNotifier {

  List<Usuario> users = [];
  List<String> get names => users.map((e) => e.nomeCompleto!).toList();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void updateUser(GerenciadorUsuario userManager){
    if(userManager.adminEnabled){
      _listenToUsers();
    }else{
      users = [];
    }
  }

  void _listenToUsers(){
    firestore.collection("users").get().then((snapshots) => (){
      users = snapshots.docs.map((e) => Usuario.fromDocumento(e)).toList();
      users.sort((a,b)=>a.nomeCompleto!.toLowerCase().compareTo(b.nomeCompleto!.toLowerCase()));
      notifyListeners();
    });

  }
}