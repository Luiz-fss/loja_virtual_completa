import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/componentes-gerais/icon-button-customizado.dart';
import 'package:loja_virtual_completa/models/item-size.dart';
import 'package:loja_virtual_completa/telas/produtos/item-tamanho.dart';

class EditItemSize extends StatelessWidget {
  final ItemSize size;
  final VoidCallback onRemove;
  final VoidCallback? onMoveUp;
  final VoidCallback? onMoveDown;
   EditItemSize({required this.size, required this.onRemove, this.onMoveDown,this.onMoveUp,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.name,
            onChanged: (name){
              size.name = name;
            },
            validator: (name){
              if(name == null || name.isEmpty){
                return "Nome inválido";
              }else{
                return null;
              }
            },
            decoration:
                const InputDecoration(labelText: "Título", isDense: true),
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.stock?.toString(),
            onChanged: (stock){
              size.stock = int.tryParse(stock);
            },
            validator: (stock){
              if(stock == null || int.tryParse(stock) == null){
                return "Inválido";
              }else{
                return null;
              }
            },
            decoration:
                const InputDecoration(labelText: "Estoque", isDense: true),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          flex: 40,
          child: TextFormField(
            initialValue: size.price?.toStringAsFixed(2),
            onChanged: (price){
              size.price = double.tryParse(price);
            },
            validator: (price){
              if(price == null || double.tryParse(price) == null){
                return "Inválido";
              }else{
                return null;
              }
            },
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
        IconButtonCustomizado(
            iconData: Icons.arrow_drop_up,
            corIcone: Colors.black,
            onTap: onMoveUp ?? (){}),
        IconButtonCustomizado(
            iconData: Icons.arrow_drop_down,
            corIcone: Colors.black,
            onTap: onMoveDown ?? (){})
      ],
    );
  }
}
