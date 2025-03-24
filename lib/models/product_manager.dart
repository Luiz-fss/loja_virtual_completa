import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_completa/models/product.dart';

class ProductManager extends ChangeNotifier {
  ProductManager() {
    _loadAllProducts();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Product> allProducts = [];

  String _search = "";

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  String get search => _search;

  List<Product> get filteredProducts {
    final List<Product> filteredProducst = [];
    if (_search.isEmpty) {
      filteredProducst.addAll(allProducts);
    } else {
      filteredProducst
          .addAll(allProducts.where((p) =>
          p.name!.toLowerCase().contains(search.toLowerCase())));
    }
    return filteredProducst;
  }

  Future<void> _loadAllProducts() async {
    final QuerySnapshot snapDocuments =
        await firestore.collection("products").where("deleted",isEqualTo: false).get();

    allProducts =
        snapDocuments.docs.map((d) => Product.fromDocument(d)).toList();

    notifyListeners();
  }

  Product? findProductByID(String id){
    try{
      return allProducts.firstWhere((p)=> p.id == id);
    }catch(e){
      return null;
    }

  }

  void update(Product product){
    allProducts.removeWhere((p)=> p.id == product.id);
    allProducts.add(product);
    notifyListeners();
  }

  void delete(Product product){
    product.delete();
    allProducts.removeWhere((p)=> p.id == product.id);
    notifyListeners();
  }
}
