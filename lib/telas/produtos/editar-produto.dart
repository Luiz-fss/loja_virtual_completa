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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    initialValue: produto.name,
                    decoration: const InputDecoration(
                      hintText: "Título",
                      border: InputBorder.none
                    ),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                    ),
                    validator: (textoTitulo){
                      if(textoTitulo!.length < 6){
                        return "Título muito curto";
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "A partir de: ",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13
                      ),
                    ),
                  ),
                  Text(
                    "R\$...",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16,bottom: 16),
                    child: Text(
                      "Descrição",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  TextFormField(
                    initialValue: produto.description,
                    style: const TextStyle(
                      fontSize: 16
                    ),
                    decoration: const InputDecoration(
                      hintText: "Descrição",
                      border: InputBorder.none
                    ),
                    maxLines: null,
                    validator: (textoDescricao){
                      if(textoDescricao!.length < 10){
                        return "Descrição muito curta";
                        }
                        return null;
                    },
                  ),
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
          ],
        ),
      ),
    );
  }
}
