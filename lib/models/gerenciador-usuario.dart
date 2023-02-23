import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual_completa/models/usuario-model.dart';

import '../helpers/erros-firebase.dart';

class GerenciadorUsuario extends ChangeNotifier{

  GerenciadorUsuario(){
    _carregarUsuarioAtual();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  User? usuarioAtual;
  bool loading = false;
  
  Future<void> signIn({required Usuario usuario, required Function onFail, required Function onSucess})async{
    setLoading(true);
   try{
     final UserCredential result = await auth.signInWithEmailAndPassword(
         email: usuario.email!, password: usuario.senha!);
     usuarioAtual = result.user;
     onSucess();
   }on PlatformException catch(e){
     onFail(pegarTextoErro(e.code));
   }
   setLoading(false);
  }

  void setLoading (bool valor){
    loading = valor;
    notifyListeners();
  }

  Future<void> _carregarUsuarioAtual()async{
    User? usuario = await auth.currentUser;
    if(usuario !=null){
      usuarioAtual = usuario;
    }
    notifyListeners();
  }

}