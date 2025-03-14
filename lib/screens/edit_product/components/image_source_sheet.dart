import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
   ImageSourceSheet({super.key, required this.onImageSelect});
   final Function(File) onImageSelect;

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    if(Platform.isAndroid){
      return BottomSheet(
        onClosing: (){},
        builder: (context){
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton(
                onPressed: ()async{
                  final XFile? file =
                  await picker.pickImage(source: ImageSource.camera);
                  if(file!=null){
                    editImage(file.path,context);
                  }
                },
                child: const Text(
                    "Câmera"
                ),
              ),
              const Divider(),
              TextButton(
                onPressed: ()async{
                 final XFile? file =
                 await picker.pickImage(source: ImageSource.gallery);
                 if(file!=null){
                   editImage(file.path,context);
                 }
                },
                child: const Text(
                    "Galeria"
                ),
              )
            ],
          );
        },
      );
    }
    return CupertinoActionSheet(
      title: const Text(
        "Selecionar foto para o item"
      ),
      message: const Text(
        "Escolha a origem da foto"
      ),
      actions: [
        CupertinoActionSheetAction(
          child: const Text("Câmera"),
          onPressed: (){},
        ),
        CupertinoActionSheetAction(
          child: const Text("Galeria"),
          onPressed: (){},
        )
      ],
    );
  }

  void editImage(String path,BuildContext context)async{
    final CroppedFile? imageCropper =
    await ImageCropper().cropImage(
        sourcePath: path,
        aspectRatio:  const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        uiSettings:  [
          AndroidUiSettings(
              toolbarTitle: "Editar imagem",
              toolbarColor: Theme.of(context).primaryColor,
              toolbarWidgetColor: Colors.white
          )
        ]
    );
    if(imageCropper != null){
      onImageSelect(File(imageCropper.path));
    }
  }
}
