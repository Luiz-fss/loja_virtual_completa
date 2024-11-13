import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual_completa/models/address.dart';

class Usuario {
  String? email;
  String? senha;
  String? nomeCompleto;
  String? confirmacaoSenha;
  String? id;
  bool? admin = false;

  Address? address;

  DocumentReference get firestoreRef => FirebaseFirestore.instance.doc("users/$id");
  CollectionReference get cartReference => firestoreRef.collection("cart");

  Usuario({this.email, this.senha});

  Usuario.fromDocumento(DocumentSnapshot documentSnapshot){
    nomeCompleto = documentSnapshot["name"] as String;
    email = documentSnapshot["email"] as String;
    id = documentSnapshot.id;
    Map<String,dynamic> data = documentSnapshot.data() as Map<String,dynamic>;
    if(data.containsKey("address")){
      address = Address.fromMap(data["address"] as Map<String,dynamic>);
    }
  }

  DocumentReference get documentRef =>
  FirebaseFirestore.instance.doc("users/$id");

  Future<void> salvarDados()async{
    documentRef.set(toMap());
  }

  Map<String,dynamic> toMap(){
    return{
      "name": nomeCompleto,
      "email": email,
      if(address != null)
        "address": address?.toMap()
    };
  }

  void setAddress(Address address){
    this.address = address;
    salvarDados();
  }
}