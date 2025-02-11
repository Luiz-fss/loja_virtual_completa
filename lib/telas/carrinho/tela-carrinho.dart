import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/componentes-gerais/login-card.dart';
import 'package:loja_virtual_completa/componentes-gerais/price-card.dart';
import 'package:loja_virtual_completa/models/cart-manager.dart';
import 'package:loja_virtual_completa/telas/carrinho/cart-tile.dart';
import 'package:provider/provider.dart';

import '../../componentes-gerais/empty-card.dart';

class TelaCarrinho extends StatelessWidget {
  const TelaCarrinho({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 125, 141),
        centerTitle: true,
        title: const Text("Carrinho"),
      ),
      body: Consumer<CartManager>(
        builder: (_, gerenciadorCarrinho, child) {

          if(gerenciadorCarrinho.user == null){
            return const LoginCard();
          }

          if(gerenciadorCarrinho.items.isNotEmpty){
            return const EmptyCard(
              iconData: Icons.remove_shopping_cart,
              title: "Nenhum produto no carrinho!",
            );
          }

          return ListView(
            children: [
              Column(
                children:
                    gerenciadorCarrinho.items.map((e) => CartTile(e)).toList(),
              ),
              PriceCard(
                buttonText: "Continuar para entrega",
                onPressed: gerenciadorCarrinho.isCartValid
                    ? () {
                  Navigator.pushNamed(context, "/address-screen");
                }
                : null,
              )
            ],
          );
        },
      ),
    );
  }
}
