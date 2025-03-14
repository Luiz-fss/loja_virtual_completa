import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/common/custom_icon_button.dart';
import 'package:loja_virtual_completa/models/item_size.dart';

class EditItemSize extends StatelessWidget {
  final ItemSize size;
  final VoidCallback? onRemove;
  final VoidCallback? onMoveUp;
  final VoidCallback? onMoveDown;
  const EditItemSize(
      {super.key,
      required this.size,
      required this.onRemove,
      required this.onMoveUp,
      required this.onMoveDown});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 30,
          child: TextFormField(
            validator: (name){
              if(name == null || name.isEmpty){
                return "Inválido";
              }
              return null;
            },
            initialValue: size.name ?? "",
            decoration:
                const InputDecoration(labelText: "Título", isDense: true),
            onChanged: (name){
              size.name = name;
            },
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.stock?.toString(),
            validator: (stock){
              if(stock == null || int.tryParse(stock)==null){
                return "Inválido";
              }
              return null;
            },
            decoration:
                const InputDecoration(labelText: "Estoque", isDense: true),
            keyboardType: TextInputType.number,
            onChanged: (stock)=>size.stock = int.tryParse(stock),
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          flex: 40,
          child: TextFormField(
            initialValue: size.price?.toStringAsFixed(2),
            validator: (price){
              if(price == null || num.tryParse(price)==null){
                return "Inválido";
              }
              return null;
            },
            decoration: const InputDecoration(
                labelText: "Preço", prefixText: "R\$", isDense: true),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (price)=>size.price = num.tryParse(price),
          ),
        ),
        CustomIconButton(
          iconData: Icons.remove,
          color: Colors.red,
          onTap: onRemove,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_up,
          color: Colors.black,
          onTap: onMoveUp,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_down,
          color: Colors.black,
          onTap: onMoveDown,
        )
      ],
    );
  }
}
