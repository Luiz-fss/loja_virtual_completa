import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual_completa/firebase_options.dart';
import 'package:loja_virtual_completa/helpers/erros-firebase.dart';
import 'package:loja_virtual_completa/models/produto.dart';
import 'package:loja_virtual_completa/models/usuario-model.dart';

class GerenciadorUsuario extends ChangeNotifier{

  GerenciadorUsuario(){
    _carregarUsuarioAtual();
  }

  late FirebaseAuth auth;



  Usuario? usuarioAtual;
  bool loading = false;
  bool get usuarioLogado => usuarioAtual != null;
  
  Future<void> signIn({required Usuario usuario, required Function onFail, required Function onSucess})async{
    setLoading(true);
   try{
     final UserCredential result = await auth.signInWithEmailAndPassword(
         email: usuario.email!, password: usuario.senha!);
     await _carregarUsuarioAtual(firebaseUser: result.user);

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

  Future<void> _carregarUsuarioAtual({User? firebaseUser})async{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    auth = FirebaseAuth.instance;

    FirebaseFirestore firebaseFirestore =  FirebaseFirestore.instance;
    User? usuario = firebaseUser ?? await auth.currentUser;
    if(usuario !=null){
      final DocumentSnapshot documentoUsuario = await
      firebaseFirestore.collection("users").doc(usuario.uid).get();
      usuarioAtual = Usuario.fromDocumento(documentoUsuario);
      notifyListeners();
    }
  }

  Future<void> signUp({required Usuario usuario, required Function onFail, required Function onSucess})async {
    setLoading(true);
    try{
      final UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: usuario.email!, password: usuario.senha!);
      //usuarioAtual = userCredential.user;
      usuario.id = userCredential.user!.uid;
      usuarioAtual = usuario;

      await usuario.salvarDados();
      onSucess();
    }catch (e){
      onFail(pegarTextoErro(e.toString()));
    }
    setLoading(false);
  }

  Future<void> signOut ()async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();
    usuarioAtual = null;
    notifyListeners();
  }

}