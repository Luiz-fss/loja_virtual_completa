import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loja_virtual_completa/models/section.dart';
import 'package:loja_virtual_completa/screens/home/components/add_tile_widget.dart';
import 'package:loja_virtual_completa/screens/home/components/item_tile.dart';
import 'package:loja_virtual_completa/screens/home/components/section_header.dart';
import 'package:provider/provider.dart';

import '../../../models/home_manager.dart';

class SectionStaggered extends StatelessWidget {
  final Section section;
  const SectionStaggered({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    return ChangeNotifierProvider.value(
      value: section,
      child: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(),
            Consumer<Section>(
              builder: (context,section,child){
                return StaggeredGridView.countBuilder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding:  EdgeInsets.zero,
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  itemCount: homeManager.editing ?section.items!.length+1 :
                  section.items?.length ?? 0,
                  itemBuilder: (context,index){
                    if(index < section.items!.length){
                      return ItemTile(
                          item:section.items![index]
                      );
                    }
                    return AddTileWidget();

                  },
                  staggeredTileBuilder: (index)=>StaggeredTile.count(2,index.isEven ? 2:1),
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
