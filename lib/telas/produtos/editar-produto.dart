import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/produto.dart';
import 'package:loja_virtual_completa/telas/produtos/components/images-form.dart';

class EditarProduto extends StatelessWidget {


  final Produto produto;
  EditarProduto(this.produto);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Editar anúncio"
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ImagesForm(produto),
        ],
      ),
    );
  }
}
