import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/produto.dart';
import 'package:loja_virtual_completa/telas/produtos/components/images-form.dart';
import 'package:loja_virtual_completa/telas/produtos/components/sizes-form.dart';

class EditarProduto extends StatelessWidget {


  final Produto produto;
  EditarProduto(Produto? p):editing = p != null, produto = p != null ? p.clone() : Produto(tamanhos: []);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final bool editing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          editing ? "Editar Produto" : "Criar Produto"
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
                    onSaved: (name) => produto.name = name,
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
                    onSaved: (desc) => produto.description = desc,
                    validator: (textoDescricao){
                      if(textoDescricao!.length < 10){
                        return "Descrição muito curta";
                        }
                        return null;
                    },
                  ),
                  SizesForm(product: produto,),
                  const SizedBox(height: 20,),
                  SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: (){
                        if(formKey.currentState!.validate()){
                          formKey.currentState!.save();
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
