import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/produto.dart';
import 'package:loja_virtual_completa/telas/produtos/components/images-form.dart';

class EditarProduto extends StatelessWidget {


  final Produto produto;
  EditarProduto(this.produto);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Editar anúncio"
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Form(
        child: ListView(
          children: [
            ImagesForm(produto),
            ElevatedButton(
              onPressed: (){
                if(formKey.currentState!.validate()){
                  print("");
                }else{
                  print("");
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).primaryColor
                ),
              ),
              child: const Text(
                "Salvar",
                style: TextStyle(
                    fontSize: 18
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
