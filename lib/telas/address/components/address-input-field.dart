import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual_completa/models/address.dart';
import 'package:loja_virtual_completa/models/gerenciador-cart.dart';
import 'package:provider/provider.dart';

class AddressInputField extends StatelessWidget {
  const AddressInputField(this.address);
  final Address address;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final cartManager = context.watch<GerenciadorCarrinho>();
    if(address.zipCode != null && cartManager.deliveryPrice == null)
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          enabled: !cartManager.loading,
          initialValue: address.street,
          decoration: const InputDecoration(
            isDense: true,
            labelText: "Rua/Avenida",
            hintText: "Av. Brasil"
          ),
          validator: (text){
            return text == null || text.isEmpty ? "Campo obrigatório": null;
          },
          onSaved: (t)=>address.street = t,
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                enabled: !cartManager.loading,
                initialValue: address.number,
                decoration: const InputDecoration(
                    isDense: true,
                    labelText: "Número",
                    hintText: "123"
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
                validator: (text){
                  return text == null || text.isEmpty ? "Campo obrigatório": null;
                },
                onSaved: (t)=>address.number = t,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: TextFormField(
                enabled: !cartManager.loading,
                initialValue: address.complement,
                decoration: const InputDecoration(
                    isDense: true,
                    labelText: "Complemento",
                    hintText: "Opcional"
                ),
                validator: (text){
                  return text == null || text.isEmpty ? "Campo obrigatório": null;
                },
                onSaved: (t)=>address.complement = t,
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
          validator: (text){
            return text == null || text.isEmpty ? "Campo obrigatório": null;
          },
          onSaved: (t)=>address.district = t,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                initialValue: address.city,
                enabled: false,
                decoration: const InputDecoration(
                    isDense: true,
                    labelText: "Cidade",
                    hintText: "Campinas"
                ),
                validator: (text){
                  return text == null || text.isEmpty ? "Campo obrigatório": null;
                },
                onSaved: (t)=>address.city = t,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: TextFormField(
                autocorrect: false,
                initialValue: address.state,
                textCapitalization: TextCapitalization.characters,
                enabled: false,
                decoration: const InputDecoration(
                    isDense: true,
                    labelText: "UF",
                    hintText: "SP",
                    counterText: ""
                ),
                validator: (text){
                  return text == null || text.isEmpty ? "Campo obrigatório": null;
                },
                maxLength: 2,
                onSaved: (t)=>address.state = t,
              ),
            )
          ],
        ),
        SizedBox(height: 8,),
        if(cartManager.loading)
          LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation(primaryColor),
            backgroundColor: Colors.transparent,
          ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              disabledBackgroundColor: primaryColor.withAlpha(100)),
          onPressed: !cartManager.loading ? ()async{
            if(Form.of(context).validate()){
              Form.of(context).save();
              try{
                await context.read<GerenciadorCarrinho>().setAddress(address);
              }catch(e){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$e'),
                  backgroundColor: Colors.red,),
                );
              }

            }
          }:null,
          child: const Text("Calcular Frete"),
        )
      ],
    );
    else if(address.zipCode != null)
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Text(
            "${address.street} - ${address.state}"
        ),
      );
    else
      return Container();
  }

}
