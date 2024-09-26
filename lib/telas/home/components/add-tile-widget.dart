import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/item-sessao.dart';
import 'package:loja_virtual_completa/models/section.dart';
import 'package:loja_virtual_completa/telas/produtos/components/image-source-sheet.dart';
import 'package:provider/provider.dart';

class AddTileWidget extends StatelessWidget {

  const AddTileWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    final sessao = context.watch<Section>();
    void onImageSelect(File file){
      sessao?.addItem(ItemSessao(image: file));
      Navigator.of(context).pop();
    }
    return AspectRatio(
        aspectRatio: 1,
        child: GestureDetector(
          onTap: (){
            if(Platform.isAndroid){
              showModalBottomSheet(context: context, builder: (context)=>
                  ImageSourceSheet(onImageSelect: onImageSelect));
            }
            showCupertinoModalPopup(context: context, builder: (context)=>
                ImageSourceSheet(onImageSelect: onImageSelect));
          },
          child: Container(
            color: Colors.white.withAlpha(30),
            child: Icon(Icons.add,color: Colors.white,),
          ),
        ),
    );
  }

}
