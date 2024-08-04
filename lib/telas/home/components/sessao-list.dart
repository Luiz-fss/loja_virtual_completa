import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/gerenciador-home.dart';
import 'package:loja_virtual_completa/models/sessao.dart';
import 'package:loja_virtual_completa/telas/home/components/add-tile-widget.dart';
import 'package:loja_virtual_completa/telas/home/components/header-sessao.dart';
import 'package:loja_virtual_completa/telas/home/components/item-tile.dart';
import 'package:provider/provider.dart';

class SessaoLista extends StatelessWidget {

  const SessaoLista({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<GerenciadorHome>();
    final sessao = context.watch<Sessao>();
    return ChangeNotifierProvider.value(
      value: sessao,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderSessao(),
            SizedBox(
              height: 150,
              child: Consumer<Sessao>(
                builder: (context,sessao,__){
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: homeManager.editing ? sessao.items!.length +1 : sessao.items!.length,
                    separatorBuilder: (_,__)=> const SizedBox(width: 4,),
                    itemBuilder: (context,index){
                      if(index < sessao.items!.length){

                        return ItemTile(
                          itemSessao: sessao.items![index],
                        );
                      }
                      return AddTileWidget();
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
