import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/services/text_formatter.dart';
import 'package:loja_virtual_completa/componentes-gerais/icon-button-customizado.dart';
import 'package:loja_virtual_completa/models/address.dart';
import 'package:loja_virtual_completa/models/cart-manager.dart';
import 'package:provider/provider.dart';

class CepInputField extends StatefulWidget {

   const CepInputField(this.address);
   final Address address;

  @override
  State<CepInputField> createState() => _CepInputFieldState();
}

class _CepInputFieldState extends State<CepInputField> {
  TextEditingController _cepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final cartManager = context.watch<CartManager>();
    String cep = "";
    _cepController.text = widget.address.zipCode ?? "";
    if(widget.address.zipCode == null){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            enabled: !cartManager.loading,
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
          if(cartManager.loading)
            LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(primaryColor),
              backgroundColor: Colors.transparent,
            ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                disabledBackgroundColor: primaryColor.withAlpha(100)),
            onPressed: !cartManager.loading ?() async{
              if(Form.of(context).validate()){
                try{
                 await context.read<CartManager>().getAddress(_cepController.text);
                }catch(e){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$e'),
                      backgroundColor: Colors.red,),
                  );
                }

              }
            }: null,
            child: const Text(
              "Buscar CEP",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "CEP: ${widget.address.zipCode}",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
          IconButtonCustomizado(
            iconData: Icons.edit,
            corIcone: primaryColor,
            onTap: (){
              context.read<CartManager>().removerAddress();
            },
          )
        ],
      ),
    );
  }
}
