import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual_completa/models/address.dart';

class UserModel{
  String? email;
  String? password;
  String? name;
  String? confirmPassowrd;
  String? id;
  bool admin=false;

  Address? address;

  DocumentReference get firestoreRef => FirebaseFirestore.instance.doc("users/$id");

  CollectionReference get cartReference => firestoreRef.collection("cart");

  UserModel({this.email,this.password,this.name,this.confirmPassowrd,this.id});

  UserModel.fromDocument(DocumentSnapshot document){
    name = document["name"] as String;
    email = document["email"] as String;
    id = document.id;
    Map<String,dynamic> data = document.data() as Map<String,dynamic>;
    if(data.containsKey("address")){
      address = Address.fromMap(data["address"] as Map<String,dynamic>);
    }
  }


  Future<void> saveData()async{
    await firestoreRef.set(toMap());
  }

  Map<String,dynamic> toMap(){
    return {
      "email":email,
      "name":name,
      if(address != null)
        "address":address!.toMap()
    };
  }

  void setAddress(Address address){
    this.address = address;
    saveData();
  }
}