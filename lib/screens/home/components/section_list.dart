import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/home_manager.dart';
import 'package:loja_virtual_completa/models/section.dart';
import 'package:loja_virtual_completa/screens/home/components/add_tile_widget.dart';
import 'package:loja_virtual_completa/screens/home/components/item_tile.dart';
import 'package:loja_virtual_completa/screens/home/components/section_header.dart';
import 'package:provider/provider.dart';

class SectionList extends StatelessWidget {
  final Section section;
  const SectionList({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    return ChangeNotifierProvider.value(
      value: section,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(),
            SizedBox(
              height: 150,
              child: Consumer<Section>(
                builder: (context,section,child){
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: homeManager.editing ?section.items!.length+1 :
                    section.items?.length ?? 0,
                    separatorBuilder: (context,index)=> const SizedBox(width: 4,),
                    itemBuilder: (context,index){
                      if(index < section.items!.length){
                        return ItemTile(item: section.items![index]);
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
