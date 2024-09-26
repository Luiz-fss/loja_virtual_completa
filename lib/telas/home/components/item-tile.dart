import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/gerenciador-home.dart';
import 'package:loja_virtual_completa/models/gerenciador-produtos.dart';
import 'package:loja_virtual_completa/models/item-sessao.dart';
import 'package:loja_virtual_completa/models/product.dart';
import 'package:loja_virtual_completa/models/section.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemTile extends StatelessWidget {
  final ItemSessao item;
  const ItemTile({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<GerenciadorHome>();
    return GestureDetector(
      child: AspectRatio(
        aspectRatio: 1,
        child: _buildImage(),
      ),
      onTap: (){
        if(item.product != null){
          Product? product = context.read<GerenciadorProduto>()
              .encontrarProdutoPorId(item.product!);
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
                    context.read<Section>().removeItem(item);
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

  Widget _buildImage(){
    if(item.image is String){
      return FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: item.image as String,
        fit: BoxFit.cover,
      );
    }
    return Image.file(item.image as File, fit: BoxFit.cover,);
  }
}
