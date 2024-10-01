import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/services/text_formatter.dart';
import 'package:loja_virtual_completa/models/gerenciador-cart.dart';
import 'package:provider/provider.dart';

class CepInputField extends StatelessWidget {
   CepInputField({super.key});

  TextEditingController _cepController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    String cep = "";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: _cepController,
          decoration: const InputDecoration(
              labelText: "CEP", isDense: true, hintText: "12.345-678"),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CepInputFormatter()
          ],
          onChanged: (cepText){
            cep=cepText;
          },
          validator: (cep){
            if(cep == null || cep.isEmpty){
              return "Campo obrigatório";
            }else if(cep.length != 10){
              return "CEP inválido";
            }
            return null;
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              disabledBackgroundColor: primaryColor.withAlpha(100)),
          onPressed: () {
            if(Form.of(context).validate()){
              context.read<GerenciadorCarrinho>().getAddress(_cepController.text);
            }
          },
          child: const Text(
            "Buscar CEP",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
