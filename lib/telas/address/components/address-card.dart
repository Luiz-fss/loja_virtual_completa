import 'package:flutter/material.dart';

import 'cep-input-field.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return  Card(
      margin: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
      child: Padding(
        padding:  EdgeInsets.fromLTRB(16, 16, 16, 4),
        child:Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Endereço de Entrega",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16
                ),
              ),
              CepInputField()
            ],
          ),
        ),
      ),
    );
  }
}
