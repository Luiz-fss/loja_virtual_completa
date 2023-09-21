import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loja_virtual_completa/models/sessao.dart';
import 'package:loja_virtual_completa/telas/home/components/header-sessao.dart';

class SessaoStaggered extends StatelessWidget {
  final Sessao sessao;
  const SessaoStaggered({Key? key, required this.sessao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderSessao(sessao:sessao),
          StaggeredGridView.countBuilder(
            shrinkWrap: true,
            crossAxisCount: 4,
            padding: EdgeInsets.zero,
            itemCount: sessao.items!.length,
            itemBuilder: (context,index){
              return Image.network(
                sessao.items![index].image!,
                fit: BoxFit.cover,
              );
            },
            staggeredTileBuilder: (index)=> StaggeredTile.count(2,index.isEven ? 2 : 1),
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          )
        ],
      ),
    );
  }
}
