import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual_completa/models/address.dart';
import 'package:loja_virtual_completa/models/cart_manager.dart';
import 'package:provider/provider.dart';

class AddressInputField extends StatelessWidget {
  final Address address;
  const AddressInputField({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();

    if(address.zipCode != null && cartManager.deliveryPrice == null) {
      return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          initialValue: address.street,
          enabled: !cartManager.loading,
          decoration: const InputDecoration(
            isDense: true,
            labelText: "Rua/Avenida",
            hintText: "Av. Brasil"
          ),
          validator: emptyValidator,
          onSaved: (t) => address.street = t,
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: address.number,
                enabled: !cartManager.loading,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: "Número",
                  hintText: "123"
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
                validator: emptyValidator,
                onSaved: (t)=> address.number = t,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: TextFormField(
                initialValue: address.complement,
                decoration: const InputDecoration(
                    isDense: true,
                    labelText: "Complemento",
                    hintText: "Opcional"
                ),
                keyboardType: TextInputType.number,
                enabled: !cartManager.loading,
                onSaved: (t)=> address.complement = t,
              ),
            ),
          ],
        ),
        TextFormField(
          enabled: !cartManager.loading,
          initialValue: address.district,
          decoration: const InputDecoration(
            isDense: true,
            labelText: "Bairro",
            hintText: "Guanabara"
          ),
          validator: emptyValidator,
          onSaved: (t)=>address.district=t,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                enabled: false,
                initialValue: address.city,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: "Cidade",
                  hintText: "São Paulo"
                ),
                validator: emptyValidator,
                onSaved: (t)=>address.city=t,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: TextFormField(
                autocorrect: false,
                enabled: false,
                textCapitalization: TextCapitalization.characters,
                initialValue: address.state,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: "UF",
                  hintText: "SP",
                  counterText: ""
                ),
                maxLength: 2,
                validator: (e){
                  if(e == null || e.isEmpty){
                    return "Campo obrigatório";
                  }else if(e.length != 2){
                    return "Inválido";
                  }
                  return null;

                },
                onSaved: (t)=>address.state = t,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        if(cartManager.loading)
          LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
            backgroundColor: Colors.transparent,
          ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              disabledBackgroundColor: Theme.of(context).primaryColor.withAlpha(100)),
          onPressed: !cartManager.loading ? ()async{
            if(Form.of(context).validate()){
              Form.of(context).save();
              try{
                await context.read<CartManager>().setAddress(address);
              }catch(e){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$e'),
                    backgroundColor: Colors.red,),
                );
              }

            }
          }:null,
          child: const Text("Calcular Frete",style: TextStyle(color: Colors.white),),
        )
      ],
    );
    } else if(address.zipCode != null){
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
              "${address.street},"
                  "${address.number}\n${address.district}\n${address.city} "
                  "- ${address.state}"),
        );
    }else{
      return Container();
    }
  }

  String? emptyValidator(String? text){
    return text == null || text.isEmpty ? "Campo obrigatório": null;
  }
}
