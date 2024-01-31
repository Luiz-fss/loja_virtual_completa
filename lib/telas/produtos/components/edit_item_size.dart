import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/componentes-gerais/icon-button-customizado.dart';
import 'package:loja_virtual_completa/models/tamanho-item.dart';
import 'package:loja_virtual_completa/telas/produtos/item-tamanho.dart';

class EditItemSize extends StatelessWidget {
  final TamanhoItem size;
  final VoidCallback onRemove;
  const EditItemSize({required this.size,required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.nome,
            decoration: const InputDecoration(
              labelText: "Título",
              isDense: true
            ),
          ),
        ),
        const SizedBox(width: 4,),
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.stock?.toString(),
            decoration: const InputDecoration(
                labelText: "Estoque",
                isDense: true
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 4,),
        Expanded(
          flex: 40,
          child: TextFormField(
            initialValue: size.preco?.toStringAsFixed(2),
            decoration: const InputDecoration(
                labelText: "Preço",
                prefixText: "R\$",
                isDense: true,
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
        ),
        IconButtonCustomizado(
          iconData: Icons.remove,
          corIcone: Colors.red,
          onTap: onRemove,
        ),
        IconButtonCustomizado(iconData: Icons.arrow_drop_up, corIcone: Colors.black, onTap: (){}),
        IconButtonCustomizado(iconData: Icons.arrow_drop_down, corIcone: Colors.black, onTap: (){})
      ],
    );
  }
}
