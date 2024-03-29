import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  ImageSourceSheet({Key? key, required this.onImageSelect}) : super(key: key);
  final ImagePicker picker = ImagePicker();
  final Function(File) onImageSelect;

  @override
  Widget build(BuildContext context) {
    return _returnImageSource(context);
  }

  Widget _returnImageSource(BuildContext context) {
    if (Platform.isAndroid) {
      return BottomSheet(
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton(
                onPressed: () async {
                  final XFile? file =
                      await picker.pickImage(source: ImageSource.camera);
                  if (file != null) {
                    editImage(file.path,context);
                  }
                },
                child: const Text("Câmera"),
              ),
              TextButton(
                onPressed: () async {
                  final file =
                      await picker.pickImage(source: ImageSource.camera);
                  if (file != null) {
                    editImage(file.path,context);
                  }
                },
                child: const Text("Galeria"),
              )
            ],
          );
        },
        onClosing: () {},
      );
    } else {
      return CupertinoActionSheet(
        title: const Text("Selecionar foto para o item."),
        message: const Text("Escolha a origem da foto"),
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancelar"),
        ),
        actions: [
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {},
            child: const Text("Câmera"),
          ),
          CupertinoActionSheetAction(
            onPressed: () {},
            child: const Text("Galeria"),
          )
        ],
      );
    }
  }


  Future<void> editImage(String path, BuildContext context) async{
    final CroppedFile? imageCropper = await ImageCropper().cropImage(
        sourcePath: path,
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        uiSettings: [
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
