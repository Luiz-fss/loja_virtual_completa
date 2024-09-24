import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/gerenciador-produtos.dart';
import 'package:loja_virtual_completa/models/produto.dart';
import 'package:loja_virtual_completa/models/item-size.dart';
import 'package:provider/provider.dart';

class ItemTamanho extends StatelessWidget {
  ItemSize size;
  ItemTamanho(this.size);

  @override
  Widget build(BuildContext context) {
    final produto = context.watch<Produto>();
    final selected = produto.selectedSize == size;
    Color color;
    if(!size.hasStock){
      color = Colors.red.withAlpha(50);
    }else if(selected){
      color = Theme.of(context).primaryColor;
    }else{
      color = Colors.grey;
    }
    return GestureDetector(
      onTap: (){
        if(size.hasStock){
          produto.selectedSize = size;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: color)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: color,
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
              child: Text(
                size.name!,
                style: const TextStyle(
                  color: Colors.white
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "R\$ ${size.price?.toStringAsFixed(2)}",
                style: TextStyle(
                  color: _retornarCorBorda(selected, context)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Color _retornarCorBorda(bool itemSelecionado, BuildContext context){
    if(!size.hasStock){
      return Colors.red;
    }else if(size.hasStock && itemSelecionado){
      return Theme.of(context).primaryColor;
    }else{
      return Colors.grey;
    }
  }
}
