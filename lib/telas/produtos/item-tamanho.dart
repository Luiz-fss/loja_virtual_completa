import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/produto.dart';
import 'package:loja_virtual_completa/models/tamanho-item.dart';

class ItemTamanho extends StatelessWidget {
  TamanhoItem tamanhos;
  ItemTamanho(this.tamanhos);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: _retornarCorBorda())
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color:  _retornarCorBorda(),
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
                color: _retornarCorBorda()
              ),
            ),
          )
        ],
      ),
    );
  }

  Color _retornarCorBorda(){
    if(tamanhos.temStock){
      return Colors.grey;
    }else{
      return Colors.red;
    }
  }
}
