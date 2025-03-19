import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_completa/models/cart_manager.dart';
import 'package:loja_virtual_completa/models/order.dart';
import 'package:loja_virtual_completa/models/product.dart';

class CheckoutManager extends ChangeNotifier {

  CartManager? cartManager;

  void updateCart(CartManager cartManager){
    this.cartManager = cartManager;
  }

  Future<void> checkout({Function? onStockFail,Function? onSuccess})async{
    loading = true;
    try{
      await _decrementStock();
    }catch(e){
      onStockFail!(e);
      debugPrint("e");
      loading = false;
      return;
    }

    //Processar pagamento

    final orderId = await _getOrderId();
    final order = OrderModel.fromCartManager(cartManager!);
    order.orderId = orderId.toString();
    order.save();

    cartManager?.clear();
    onSuccess!();
    loading = false;


  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<int> _getOrderId()async{
    final ref = firestore.doc("aux/ordercounter");
    try{
      final result = await firestore.runTransaction((tx)async{
        final doc = await tx.get(ref);
        final orderId = doc["current"] as int;
        await tx.update(ref, {"current":orderId+1});
        return {"orderId":orderId};
      });
      return result["orderId"]as int;
    }catch(e){
      debugPrint("");
      return Future.error('Falha');
    }



  }

  Future<void> _decrementStock()async {

    //ler stock
    //se estoque valido, decrementar local
    //salvar no firebase
    
    return firestore.runTransaction((tx)async{
      final List<Product> productsToUpdate = [];
      final List<Product> productsWithoutStock = [];
      for(final cartProduct in cartManager!.items){
        Product product;
        if(productsToUpdate.any((element)=> element.id == cartProduct.productId)){
          product = productsToUpdate.firstWhere((element)=> element.id == cartProduct.productId);
        }else{
          final doc = await tx.get(firestore.doc("products/${cartProduct.productId}"));
           product = Product.fromDocument(doc);
        }

        cartProduct.product = product;

        final size = product.findSize(cartProduct.size!);

        if(size!.stock! - cartProduct.quantity! < 0){
          //falha
          productsWithoutStock.add(product);
        }else{
          size!.stock = size.stock! - cartProduct.quantity!;
          productsToUpdate.add(product);
        }

      }

      if(productsWithoutStock.isNotEmpty){
        return Future.error("Produtos sem estoque");
      }

      for(final product in productsToUpdate){
        tx.update(firestore.doc("products/${product.id}"),
            {"sizes": product.exportSizeList()});
      }
    });
  }


}