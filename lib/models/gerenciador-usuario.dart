import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual_completa/models/usuario-model.dart';

class GerenciadorUsuario {

  FirebaseAuth auth = FirebaseAuth.instance;
  
  Future<void> signIn(Usuario usuario)async{
   try{
     final UserCredential result = await auth.signInWithEmailAndPassword(
         email: usuario.email!, password: usuario.senha!);
   }on PlatformException catch(e){

   }

  }

}