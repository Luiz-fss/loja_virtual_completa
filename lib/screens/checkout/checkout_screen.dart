

import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/cart_manager.dart';
import 'package:loja_virtual_completa/models/checkout-manager.dart';
import 'package:loja_virtual_completa/screens/checkout/components/credit_card_widget.dart';
import 'package:provider/provider.dart';

import '../../common/price_card.dart';

class CheckoutScreen extends StatelessWidget {
   CheckoutScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager,CheckoutManager>(
      create: (_)=> CheckoutManager(),
      lazy: false,
      update: (context,cartManager,checkoutManager)=>checkoutManager!..updateCart(cartManager),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Pagamento",style: TextStyle(color: Colors.white),),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Consumer<CheckoutManager>(
          builder: (context,checkoutManager,child){
            if(checkoutManager.loading){
              return const Center(
                child:  Column(
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Prcessando seu pagamento",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800
                      ),
                    )
                  ],
                ),
              );
            }
            return Form(
              key: formKey,
              child: ListView(
                children: [
                  CreditCardWidget(),
                  PriceCard(
                    buttonText: "Finalizar Pedido",
                    onPressed: (){
                      if(formKey.currentState!.validate()){
                        checkoutManager.checkout(
                            onSuccess: (order){

                              Navigator.of(context).pushNamed("/base");
                              Navigator.of(context).pushNamed("/confirmation",arguments: order);


                            },
                            onStockFail: (e){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Não tem estoque suficiente'),
                                  backgroundColor: Colors.red,),
                              );
                              Navigator.of(context).popUntil((route)=> route.settings.name == "/cart");
                            }
                        );
                      }

                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
