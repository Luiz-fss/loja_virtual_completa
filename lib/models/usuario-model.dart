import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String? email;
  String? senha;
  String? nomeCompleto;
  String? confirmacaoSenha;
  String? id;

  Usuario({this.email, this.senha});

  DocumentReference get documentRef =>
  FirebaseFirestore.instance.doc("users/$id");

  Future<void> salvarDados()async{
    documentRef.set(toMap());
  }

  Map<String,dynamic> toMap(){
    return{
      "name": nomeCompleto,
      "email": email
    };
  }
}