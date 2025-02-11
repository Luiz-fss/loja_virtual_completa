import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/componentes-gerais/price-card.dart';
import 'package:loja_virtual_completa/models/checkout-manager.dart';
import 'package:loja_virtual_completa/models/cart-manager.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager,CheckoutManager>(
      create: (context) => CheckoutManager(),
      update: (context,cartManager,checkoutManager){
        return checkoutManager!..updateCart(cartManager);
      },
      lazy: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Pagamento"),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            PriceCard(
              buttonText: "Finalizar Pedido",
              onPressed: (){

              },
            )
          ],
        ),
      ),
    );
  }
}
