import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/home_manager.dart';
import 'package:loja_virtual_completa/models/product.dart';
import 'package:loja_virtual_completa/models/product_manager.dart';
import 'package:loja_virtual_completa/models/section.dart';
import 'package:loja_virtual_completa/models/section_item.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemTile extends StatelessWidget {
  final SectionItem item;
  const ItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    final section = context.watch<Section>();
    final productManager = context.watch<ProductManager>();
    return GestureDetector(
      onLongPress: homeManager.editing
          ? () {
              showDialog(
                  context: context,
                  builder: (context) {
                    final product =
                        productManager.findProductByID(item.product??"");
                    return AlertDialog(
                      title: const Text("Editar item"),
                      content: product != null
                          ? ListTile(
                              leading: Image.network(product.images!.first),
                              contentPadding:  EdgeInsets.zero,
                              title: Text(product.name!),
                              subtitle: Text(
                                  "R\$ ${product.basePrice.toStringAsFixed(2)}"),
                            )
                          : null,
                      actions: [
                        TextButton(
                          onPressed: () {
                            section.removeItem(item);
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            "Excluir",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextButton(
                          onPressed: ()async{
                            if(product != null){
                              item.product = null;
                            }else{
                              final Product? product =
                              await Navigator.pushNamed(context,
                                "/select_product",)as Product;
                              if(product != null){
                                item.product = product!.id;
                              }

                            }
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            product != null ? "Desvincular": "Vincular"
                          ),
                        )
                      ],
                    );
                  });
            }
          : null,
      onTap: () {
        if (item.product != null) {
          final product = context
              .read<ProductManager>()
              .findProductByID(item.product ?? "");
          if (product != null) {
            Navigator.of(context).pushNamed("/product", arguments: product);
          }
        }
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: item.image is String
            ? FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: item.image ?? "",
                fit: BoxFit.cover,
              )
            : Image.file(
                item.image as File,
                fit: BoxFit.cover,
              ),
      ),
    );
    ;
  }
}
