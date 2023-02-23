import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual_completa/models/usuario-model.dart';

import '../helpers/erros-firebase.dart';

class GerenciadorUsuario extends ChangeNotifier{

  FirebaseAuth auth = FirebaseAuth.instance;

  bool loading = false;
  
  Future<void> signIn({required Usuario usuario, required Function onFail, required Function onSucess})async{
    setLoading(true);
   try{
     final UserCredential result = await auth.signInWithEmailAndPassword(
         email: usuario.email!, password: usuario.senha!);
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

}