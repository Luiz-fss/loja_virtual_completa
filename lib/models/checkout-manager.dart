import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_completa/models/cart_manager.dart';

class CheckoutManager extends ChangeNotifier {

  CartManager? cartManager;

  void updateCart(CartManager cartManager){
    this.cartManager = cartManager;
  }


}