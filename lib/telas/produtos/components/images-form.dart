import 'dart:io';

import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/produto.dart';
import 'package:loja_virtual_completa/telas/produtos/components/image-source-sheet.dart';

class ImagesForm extends StatelessWidget {
  final Produto produto;

  ImagesForm(this.produto);

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: produto.images!,
      validator: (images) {
        if (images!.isEmpty) {
          return "Insira ao menos uma imagem";
        } else {
          return null;
        }
      },
      builder: (state) {
        return Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: BannerCarousel(
                customizedBanners: state.value?.map<Widget>((image) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      _retornarImagem(image),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            state.value?.remove(image);
                            state.didChange(state.value);
                          },
                          color: Colors.red,
                        ),
                      )
                    ],
                  );
                }).toList()
                  ?..add(Material(
                    color: Colors.grey[100],
                    child: IconButton(
                      onPressed: () {
                        if (Platform.isAndroid) {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return ImageSourceSheet(
                                  onImageSelect: (file) {
                                    state.value?.add(file);
                                    state.didChange(state.value);
                                    Navigator.of(context).pop();
                                  },
                                );
                              });
                        } else {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) {
                              return ImageSourceSheet(
                                onImageSelect: (file) {
                                  state.value?.add(file);
                                  state.didChange(state.value);
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                          );
                        }
                      },
                      icon: const Icon(Icons.add_a_photo),
                      color: Theme.of(context).primaryColor,
                      iconSize: 50,
                    ),
                  )),
                activeColor: Theme.of(context).primaryColor,
                animation: true,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            if (state.hasError)
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 16,left: 16),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              )
          ],
        );
      },
    );
  }

  Widget _retornarImagem(dynamic image) {
    if (image is String) {
      return Image.network(
        image,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        image as File,
        fit: BoxFit.cover,
      );
    }
  }
}
