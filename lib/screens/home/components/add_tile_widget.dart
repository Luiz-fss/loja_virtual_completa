import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/section.dart';
import 'package:loja_virtual_completa/models/section_item.dart';
import 'package:loja_virtual_completa/screens/edit_product/components/image_source_sheet.dart';
import 'package:provider/provider.dart';

class AddTileWidget extends StatelessWidget {

  const AddTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final section = context.watch<Section>();
    void onImageSelected(File file){
      section.addItem(SectionItem(image: file));
      Navigator.of(context).pop();
    }
    return ChangeNotifierProvider.value(
      value:section,
      child: AspectRatio(
        aspectRatio: 1,
        child: GestureDetector(
          onTap: () {
            if (Platform.isAndroid) {
              showBottomSheet(
                  context: context,
                  builder: (context) =>
                      ImageSourceSheet(onImageSelect: onImageSelected));
            } else {
              showCupertinoModalPopup(
                  context: context,
                  builder: (context) =>
                      ImageSourceSheet(onImageSelect: onImageSelected));
            }
          },
          child: Container(
            color: Colors.white.withAlpha(30),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );

  }
}
