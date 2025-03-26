import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual_completa/screens/checkout/components/card_text_field.dart';

class CardBack extends StatelessWidget {
  final FocusNode cvvFocus;
  const CardBack({super.key, required this.cvvFocus});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 16,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        height: 200,
        color: const Color(0xff1b4b52),
        child: Column(
          children: [
            Container(
              color: Colors.black,
              height: 40,
              margin: const EdgeInsets.symmetric(vertical: 16),
            ),
            Row(
              children: [
                Expanded(
                  flex: 70,
                  child: Container(
                    margin: const EdgeInsets.only(left: 12),
                    padding:  const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
                    color: Colors.grey[500],
                    child: CardTextField(
                      title: "",
                      focusNode: cvvFocus,
                      onSubmitted: (_){},
                      hint: "123",
                      maxLength: 3,
                      textAlign: TextAlign.end,
                      bold: false,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (cvv){
                        if(cvv == null || cvv.length != 3){
                          return "Inválido";
                        }
                        return null;
                      },
                      textInputType: TextInputType.number,
                    ),
                  ),
                ),
                Expanded(
                    flex:30,
                    child: Container())
              ],
            )
          ],
        ),
      ),
    );
  }
}
