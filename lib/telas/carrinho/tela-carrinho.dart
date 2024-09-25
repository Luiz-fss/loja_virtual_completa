import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/componentes-gerais/price-card.dart';
import 'package:loja_virtual_completa/models/gerenciador-cart.dart';
import 'package:loja_virtual_completa/telas/carrinho/cart-tile.dart';
import 'package:provider/provider.dart';

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
      body: Consumer<GerenciadorCarrinho>(
        builder: (_, gerenciadorCarrinho, child) {
          return ListView(
            children: [
              Column(
                children:
                    gerenciadorCarrinho.items.map((e) => CartTile(e)).toList(),
              ),
              PriceCard(
                buttonText: "Continuar para entrega",
                onPressed: gerenciadorCarrinho.isCartValid
                    ? () {}
                : null,
              )
            ],
          );
        },
      ),
    );
  }
}
