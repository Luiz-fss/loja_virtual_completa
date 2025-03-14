import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual_completa/common/custom_icon_button.dart';
import 'package:loja_virtual_completa/models/address.dart';
import 'package:loja_virtual_completa/models/cart_manager.dart';
import 'package:provider/provider.dart';

class CepInputField extends StatefulWidget {
  final Address address;
  const CepInputField({required this.address});



  @override
  State<CepInputField> createState() => _CepInputFieldState();
}

class _CepInputFieldState extends State<CepInputField> {
  final TextEditingController cepController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();

    if (widget.address.zipCode == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            enabled: !cartManager.loading,
            decoration: const InputDecoration(
                isDense: true, labelText: "CEP", hintText: "12.345-678"),
            controller: cepController,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CepInputFormatter()
            ],
            validator: (cep) {
              if (cep == null || cep.isEmpty) {
                return "Cep obrigatório";
              } else if (cep!.length != 10) {
                return "Cep Inválido";
              }
              return null;
            },
            keyboardType: TextInputType.number,
          ),
          if (cartManager.loading)
            LinearProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation(Theme.of(context).primaryColor),
              backgroundColor: Colors.transparent,
            ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                disabledBackgroundColor:
                    Theme.of(context).primaryColor.withAlpha(100)),
            onPressed: !cartManager.loading
                ? () async{

                    if (Form.of(context).validate()) {
                      try{
                        await context
                            .read<CartManager>()
                            .getAddress(cepController.text);
                      }catch(e){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$e'),
                            backgroundColor: Colors.red,),
                        );
                      }

                    }
                  }
                : null,
            child: const Text(
              "Buscar CEP",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "CEP: ${widget.address.zipCode}",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600),
              ),
            ),
            CustomIconButton(
              iconData: Icons.edit,
              color: Theme.of(context).primaryColor,
              onTap: () {
                context.read<CartManager>().removeAddress();
              },
            )
          ],
        ),
      );
    }
  }
}
