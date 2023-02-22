import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async{
  runApp(const MyApp());
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseAuth auth = FirebaseAuth.instance;

  var db = FirebaseFirestore.instance;
  db.collection("users").add({"a":"a"}).then((DocumentReference doc) =>
      print('DocumentSnapshot added with ID: ${doc.id}'));
  db.collection("pedidos").doc("idEspecifico").update({"a":"a"});
  db.collection("colecaoQueQuerLer").doc("idDOcumentoParaLer").get();
  db.collection("colecao").doc("status").snapshots().listen((event) {
    //colocar o que você quer fazer quando mudar
  });
  db.collection('contatos').doc("key").snapshots().forEach((element) {
    //criar uma varivael para ir recebendo o contudo do for

    List<DocumentSnapshot> listaDocs =[];
    listaDocs.add(element);
  });


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(color: Colors.red,),
    );
  }
}
