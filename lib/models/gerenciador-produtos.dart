import 'package:cloud_firestore/cloud_firestore.dart';

class GerenciadorProduto {

  GerenciadorProduto(){
    _carregarTodosProdutos();
  }

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> _carregarTodosProdutos()async{
    QuerySnapshot snapshotProducts = await
    firebaseFirestore.collection("products").get();

    for (DocumentSnapshot doc in snapshotProducts.docs){
      print(doc.id);
    }
  }
}