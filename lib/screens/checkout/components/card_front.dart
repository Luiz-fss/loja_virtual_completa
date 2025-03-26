import 'package:brasil_fields/brasil_fields.dart';
import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:credit_card_type_detector/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual_completa/screens/checkout/components/card_text_field.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CardFront extends StatelessWidget {
  final FocusNode nameFocus;
  final FocusNode numberFocus;
  final FocusNode dateFocus;
  final VoidCallback finished;
   CardFront({super.key, required this.nameFocus, required this.numberFocus, required this.dateFocus, required this.finished});

  final dateFormatter = MaskTextInputFormatter(
    mask: "##/####",
    filter: {"#":RegExp("[0-9]")}
  );

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 16,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(24),
        color: const Color(0xff1b4b52),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CardTextField(
                    title: "Numero",
                    focusNode: numberFocus,
                    onSubmitted: (_){
                      dateFocus.requestFocus();
                    },
                    hint: "0000 0000 0000 0000",
                    maxLength: 25,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CartaoBancarioInputFormatter()
                    ],
                    textInputType: TextInputType.number,
                    bold: true,
                    validator: (number){
                      List<CreditCardType> cardTypes = detectCCType(number ?? "");
                      if(number == null || number != 19){
                        return "Inválido";
                      }else if(cardTypes.isEmpty){
                        return "Inválido";
                      }
                      return null;
                    },
                  ),
                  CardTextField(
                    onSubmitted: (_){
                      nameFocus.requestFocus();
                    },
                    title: "Validade",
                    hint: "11/2020",
                    textInputType: TextInputType.number,
                    bold: false,
                    focusNode: dateFocus,
                    maxLength: 7,
                    inputFormatters: [
                      dateFormatter,FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (date){
                      if(date ==null || date.length !=7){
                        return "Inválido";
                      }
                      return null;
                    },
                  ),
                  CardTextField(
                    title: "Títular",
                    hint: "Memphis Depay",
                    maxLength: 100,
                    focusNode: nameFocus,
                    textInputType: TextInputType.text,
                    onSubmitted: (_){
                      finished();
                    },
                    validator: (name){
                      if(name == null || name.isEmpty){
                        return "Inválido";
                      }
                      return null;
                    },
                    bold: true,
                    inputFormatters: [
                      
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
