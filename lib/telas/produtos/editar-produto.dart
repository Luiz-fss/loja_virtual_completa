import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/gerenciador-produtos.dart';
import 'package:loja_virtual_completa/models/product.dart';
import 'package:loja_virtual_completa/telas/produtos/components/images-form.dart';
import 'package:loja_virtual_completa/telas/produtos/components/sizes-form.dart';
import 'package:provider/provider.dart';

class EditarProduto extends StatelessWidget {
  final Product product;
  EditarProduto(Product? p)
      : editing = p != null,
        product = p != null ? p.clone() : Product();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final bool editing;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: product,
        child: Scaffold(
          appBar: AppBar(
            title: Text(editing ? "Editar Produto" : "Criar Produto"),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          body: Form(
            child: ListView(
              children: [
                ImagesForm(product),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        initialValue: product.name,
                        decoration: const InputDecoration(
                            hintText: "Título", border: InputBorder.none),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                        onSaved: (name) => product.name = name,
                        validator: (textoTitulo) {
                          if (textoTitulo!.length < 6) {
                            return "Título muito curto";
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          "A partir de: ",
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 13),
                        ),
                      ),
                      Text(
                        "R\$...",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 16),
                        child: Text(
                          "Descrição",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      TextFormField(
                        initialValue: product.description,
                        style: const TextStyle(fontSize: 16),
                        decoration: const InputDecoration(
                            hintText: "Descrição", border: InputBorder.none),
                        maxLines: null,
                        onSaved: (desc) => product.description = desc,
                        validator: (textoDescricao) {
                          if (textoDescricao!.length < 10) {
                            return "Descrição muito curta";
                          }
                          return null;
                        },
                      ),
                      SizesForm(
                        product: product,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<Product>(
                        builder: (context, product, _) {
                          return SizedBox(
                            height: 44,
                            child: ElevatedButton(
                              onPressed: !product.loading
                                  ? () async{
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  await product.save();
                                  context.read<GerenciadorProduto>().update(product);
                                  Navigator.of(context).pop();
                                } else {
                                  print("");
                                }
                              }
                                  : null,
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                              ),
                              child: product.loading
                                  ? const CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    )
                                  : const Text(
                                      "Salvar",
                                      style: TextStyle(fontSize: 18),
                                    ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
