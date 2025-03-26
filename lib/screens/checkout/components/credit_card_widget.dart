import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/screens/checkout/components/card_back.dart';
import 'package:loja_virtual_completa/screens/checkout/components/card_front.dart';

class CreditCardWidget extends StatelessWidget {
  CreditCardWidget({super.key});

  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  final numberFocus = FocusNode();
  final cvvFocus = FocusNode();
  final nameFocus = FocusNode();
  final dateFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FlipCard(
            key: cardKey,
            direction: FlipDirection.HORIZONTAL,
            speed: 700,
            flipOnTouch: false,
            front: CardFront(
              numberFocus: numberFocus,
              dateFocus: dateFocus,
              nameFocus: nameFocus,
              finished: (){
                cardKey.currentState!.toggleCard();
                cvvFocus.requestFocus();
              },
            ),
            back: CardBack(
              cvvFocus:cvvFocus
            ),
          ),
          TextButton(
            onPressed: (){
              cardKey.currentState!.toggleCard();
            },
            child: const Text(
              "Virar cartão",
              style: TextStyle(
                color: Colors.white
              ),
            ),
          )
        ],
      ),
    );
  }
}
