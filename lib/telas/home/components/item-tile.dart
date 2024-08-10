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
            final product = context.read<GerenciadorProduto>().encontrarProdutoPorId(itemSessao.product!);
            return AlertDialog(
              title: const Text("Editar item"),
              content: product != null
                  ? ListTile(
                title: Text(product.name!),
                contentPadding:  EdgeInsets.zero,
                leading: Image.network(product.images!.first),
                subtitle: Text("R\$ ${product.basePrice.toStringAsFixed(2)}"),
              )  :null,
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
                ),
                FloatingActionButton(
                  onPressed: ()async{
                    if(product != null){
                      itemSessao.product == null;
                      Navigator.of(context).pop();
                      return ;
                    }
                    final Produto? selectedProduct = await Navigator.pushNamed(context, "selecionar-produto") as Produto;
                    itemSessao.product = selectedProduct?.id;
                  },
                  child: Text(
                   product != null ? "Desvincular" : "Vincular",
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
