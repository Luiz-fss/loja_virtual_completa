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
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
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
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              disabledBackgroundColor: primaryColor.withAlpha(100)),
          onPressed: (){
            if(Form.of(context).validate()){
              Form.of(context).save();
              context.read<GerenciadorCarrinho>().setAddress(address);
            }
          },
          child: const Text("Calcular Frete"),
        )
      ],
    );
  }

}
