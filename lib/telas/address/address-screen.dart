import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/componentes-gerais/price-card.dart';
import 'package:loja_virtual_completa/models/gerenciador-cart.dart';
import 'package:provider/provider.dart';

import 'components/address-card.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrega"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AddressCard(),

          Consumer<GerenciadorCarrinho>(
            builder: (_, cartManager,__){
              return PriceCard(
                buttonText: "Continuar para pagamento",
                onPressed: cartManager.isAddressValid ? () {}:null,
              );
            },
          )
        ],
      ),
    );
  }
}
