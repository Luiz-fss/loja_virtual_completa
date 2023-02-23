import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual_completa/firebase_options.dart';
import 'package:loja_virtual_completa/helpers/erros-firebase.dart';
import 'package:loja_virtual_completa/models/usuario-model.dart';

class GerenciadorUsuario extends ChangeNotifier{

  GerenciadorUsuario(){

    _carregarUsuarioAtual();
  }

  late FirebaseAuth auth;

  User? usuarioAtual;
  bool loading = false;
  
  Future<void> signIn({required Usuario usuario, required Function onFail, required Function onSucess})async{
    setLoading(true);
   try{
     final UserCredential result = await auth.signInWithEmailAndPassword(
         email: usuario.email!, password: usuario.senha!);
     usuarioAtual = result.user;
     onSucess();
   } catch(e){
     onFail(pegarTextoErro(e.toString()));
   }
   setLoading(false);
  }

  void setLoading (bool valor){
    loading = valor;
    notifyListeners();
  }

  Future<void> _carregarUsuarioAtual()async{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    auth = FirebaseAuth.instance;
    User? usuario = await auth.currentUser;
    if(usuario !=null){
      usuarioAtual = usuario;
    }
    notifyListeners();
  }

}