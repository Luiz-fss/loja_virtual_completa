import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loja_virtual_completa/models/gerenciador-home.dart';
import 'package:loja_virtual_completa/models/section.dart';
import 'package:loja_virtual_completa/telas/home/components/add-tile-widget.dart';
import 'package:loja_virtual_completa/telas/home/components/header-sessao.dart';
import 'package:loja_virtual_completa/telas/home/components/item-tile.dart';
import 'package:provider/provider.dart';

class SessaoStaggered extends StatelessWidget {
  final Section section;
  const SessaoStaggered(this.section);

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<GerenciadorHome>();
    return ChangeNotifierProvider.value(
      value: section,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderSessao(),
            Consumer<Section>(
              builder: (context,sessao,__){
                return StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: homeManager.editing ? sessao.items!.length +1 : sessao.items!.length,
                  itemBuilder: (context,index){
                    if(index < sessao.items!.length){
                      return ItemTile(
                          item:sessao.items![index]
                      );
                    }
                    return AddTileWidget();

                  },
                  staggeredTileBuilder: (index)=> StaggeredTile.count(2,index.isEven ? 2 : 1),
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
