import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/gerenciador-produtos.dart';
import 'package:loja_virtual_completa/models/item-sessao.dart';
import 'package:loja_virtual_completa/models/produto.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemTile extends StatelessWidget {
  final ItemSessao itemSessao;
  const ItemTile({Key? key, required this.itemSessao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AspectRatio(
        aspectRatio: 1,
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: itemSessao.image!,
          fit: BoxFit.cover,
        )
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
    );
  }
}
