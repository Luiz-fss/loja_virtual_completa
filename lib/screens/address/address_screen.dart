import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/common/price_card.dart';
import 'package:loja_virtual_completa/models/cart_manager.dart';
import 'package:loja_virtual_completa/screens/address/components/address_card.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Entrega",style: TextStyle(color: Colors.white),),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,

      ),
      body: ListView(
        children: [
          AddressCard(),
          Consumer<CartManager>(
            builder: (context,cartManager,child){
                return PriceCard(
                  buttonText: "Continuar para Pagamento",
                  onPressed: cartManager.isAddressValid ? (){
                    Navigator.of(context).pushNamed("/checkout");
                  }:null,
                );
            },
          )
        ],
      ),
    );
  }
}
