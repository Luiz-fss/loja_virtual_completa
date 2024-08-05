import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/gerenciador-home.dart';
import 'package:loja_virtual_completa/models/gerenciador-produtos.dart';
import 'package:loja_virtual_completa/models/item-sessao.dart';
import 'package:loja_virtual_completa/models/produto.dart';
import 'package:loja_virtual_completa/models/sessao.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemTile extends StatelessWidget {
  final ItemSessao itemSessao;
  const ItemTile({Key? key, required this.itemSessao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<GerenciadorHome>();
    return GestureDetector(
      child: AspectRatio(
        aspectRatio: 1,
        child: itemSessao is String ?
        FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: itemSessao.image!,
          fit: BoxFit.cover,
        ): Image.file(itemSessao.image as File,fit: BoxFit.cover,)
      ),
      onTap: (){
        if(itemSessao.product != null){
          Produto? product = context.read<GerenciadorProduto>()
              .encontrarProdutoPorId(itemSessao.product!);
          if(product !=null){
            Navigator.of(context).pushNamed("/detalhe-produto",arguments: product);
          }
        }
      },
      onLongPress: homeManager.editing ? (){
        showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: const Text("Editar item"),
              actions: [
                FloatingActionButton(
                  onPressed: (){
                    context.read<Sessao>().removeItem(itemSessao);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Excluir",
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            );
          }
        );
      } : null,
    );
  }
}
