import 'dart:io';

import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/product.dart';
import 'package:loja_virtual_completa/screens/edit_product/components/image_source_sheet.dart';

class ImagesForm extends StatelessWidget {
  final Product product;
  const ImagesForm({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: List.from(product.images!),
      validator: (images){
        if(images == null || images.isEmpty){
          return "Insira alguma imagem";
        }
        return null;
      },
      onSaved: (images)=>product.newImages = images,
      builder: (state){
        void onImageSelected(File file){
          state.value!.add(file);
          state.didChange(state.value);
          Navigator.of(context).pop();
        }

        return  Column(
          children: [
            BannerCarousel(
              activeColor: Colors.amber,
              animation: true,
              borderRadius: 25,
              height: 400,
              customizedBanners: state.value?.map<Widget>((image){
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    if(image is String)
                      Image.network(image ?? "",fit: BoxFit.cover,)
                    else
                      Image.file(image as File,fit: BoxFit.cover,),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.remove,color: Colors.red,),
                        onPressed: (){
                          state.value?.remove(image);
                          state.didChange(state.value); //vai fazer papel do setState
                        },
                      ),
                    )
                  ],
                );
              }).toList()?..add(Material(
                color: Colors.grey[100],
                child: IconButton(
                  icon: Icon(Icons.add_a_photo,size: 50,),
                  color: Theme.of(context).primaryColor,
                  onPressed: (){
                    if(Platform.isAndroid){
                      showModalBottomSheet(context: context, builder: (context)=> ImageSourceSheet(
                        onImageSelect: onImageSelected,
                      ));
                    }else{
                      showCupertinoModalPopup(context: context, builder: (context)=>ImageSourceSheet(
                        onImageSelect: onImageSelected,
                      ));
                    }
                  },
                ),
              ))
            ),
            if(state.hasError)
               Container(
                 alignment: Alignment.centerLeft,
                 margin: const EdgeInsets.only(top: 18,left: 18),
                 child: Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12
                  ),
                               ),
               )
          ],
        );
      },
    );
  }


}
