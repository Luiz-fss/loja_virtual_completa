import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/services/text_formatter.dart';

class CepInputField extends StatelessWidget {
  const CepInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          decoration: const InputDecoration(
              labelText: "CEP", isDense: true, hintText: "12.345-678"),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              disabledBackgroundColor: primaryColor.withAlpha(100)),
          onPressed: () {},
          child: const Text(
            "Buscar CEP",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
