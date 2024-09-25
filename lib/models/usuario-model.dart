import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String? email;
  String? senha;
  String? nomeCompleto;
  String? confirmacaoSenha;
  String? id;
  bool? admin = false;

  DocumentReference get firestoreRef => FirebaseFirestore.instance.doc("users/$id");
  CollectionReference get cartReference => firestoreRef.collection("cart");

  Usuario({this.email, this.senha});

  Usuario.fromDocumento(DocumentSnapshot documentSnapshot){
    nomeCompleto = documentSnapshot["name"] as String;
    email = documentSnapshot["email"] as String;
    id = documentSnapshot.id;
  }

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