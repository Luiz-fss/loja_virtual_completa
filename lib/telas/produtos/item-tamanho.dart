import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/gerenciador-produtos.dart';
import 'package:loja_virtual_completa/models/produto.dart';
import 'package:loja_virtual_completa/models/tamanho-item.dart';
import 'package:provider/provider.dart';

class ItemTamanho extends StatelessWidget {
  TamanhoItem tamanhos;
  ItemTamanho(this.tamanhos);

  @override
  Widget build(BuildContext context) {
    final produto = context.watch<Produto>();
    print("build");

    bool selecionado = produto.itemSelecionado;
    return GestureDetector(
      onTap: (){
        if(tamanhos.temStock){
          produto.marcarItemSelecionado(!produto.itemSelecionado);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: _retornarCorBorda(selecionado, context))
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color:  _retornarCorBorda(selecionado, context),
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
              child: Text(
                tamanhos.nome!,
                style: const TextStyle(
                  color: Colors.white
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "R\$ ${tamanhos.preco}",
                style: TextStyle(
                  color: _retornarCorBorda(selecionado, context)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Color _retornarCorBorda(bool itemSelecionado, BuildContext context){
    if(!tamanhos.temStock){
      return Colors.red;
    }else if(tamanhos.temStock && itemSelecionado){
      return Theme.of(context).primaryColor;
    }else{
      return Colors.grey;
    }
  }
}
