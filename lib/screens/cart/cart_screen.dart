import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/common/login_card.dart';
import 'package:loja_virtual_completa/common/price_card.dart';
import 'package:loja_virtual_completa/models/cart_manager.dart';
import 'package:provider/provider.dart';

import '../../common/empty_card.dart';
import 'components/cart_tile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Carrinho",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Consumer<CartManager>(
        builder: (context, cartManager, child) {
          if(cartManager.user == null){
            return LoginCard();
          }
          if(cartManager.items.isEmpty){
            return const EmptyCard(
              iconData: Icons.remove_shopping_cart,
              title: "Nenhum produto no carrinho",
            );
          }
          return ListView(
            children: [
              Column(
                children: cartManager.items
                    .map((cartProduct) => CartTile(cartProduct: cartProduct))
                    .toList(),
              ),
              PriceCard(
                buttonText: "Continuar para entrega",
                onPressed: cartManager.isCartValid ? (){
                  Navigator.of(context).pushNamed("/address");
                } : null,
              )
            ],
          );
        },
      ),
    );
  }
}
