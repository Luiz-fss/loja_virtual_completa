import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/product.dart';
import 'package:loja_virtual_completa/models/product_manager.dart';
import 'package:loja_virtual_completa/screens/edit_product/components/images_form.dart';
import 'package:loja_virtual_completa/screens/edit_product/components/sizes_form.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatelessWidget {
  final Product product;
  final bool editing;
  EditProductScreen(Product? p)
      :editing = p?.name != null,
        product = p != null ? p.clone() : Product();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            if(editing)
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: (){
                  context.read<ProductManager>().delete(product);
                  Navigator.of(context).pop();
                },
              )
          ],
          title:  Text(
            editing ? "Editar Produto": "Criar Produto",
            style: const TextStyle(
                color: Colors.white
            ),
          ),
          centerTitle: true,
        ),
        body: Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              ImagesForm(product: product,),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      initialValue: product.name ?? "",
                      decoration: const InputDecoration(
                          hintText: "Título",
                          border: InputBorder.none
                      ),
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                      validator: (name){
                        if(name == null || name.length < 8){
                          return "Título muito curto";
                        }
                        return null;
                      },
                      onSaved: (name)=> product.name = name,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "A partir de:",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600]
                        ),
                      ),
                    ),
                    Text(
                      "R\$ ...",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 18),
                      child: Text(
                        "Descrição",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    TextFormField(
                      initialValue: product.description ?? "",
                      maxLines: null,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      decoration: const InputDecoration(
                          hintText: "Descrição",
                          border: InputBorder.none
                      ),
                      validator: (desc){
                        if(desc == null || desc.length < 10){
                          return "Descrição muito curta";
                        }
                        return null;
                      },
                      onSaved: (desc)=> product.description = desc,
                    ),

                    SizesForm(product:product),
                    const SizedBox(height: 20,),
                    Consumer<Product>(
                      builder: (context, product,child){
                        return  SizedBox(
                          height: 44,
                          child: ElevatedButton(
                            onPressed: !product.loading ? ()async{
                              if(formKey.currentState!.validate()){
                                formKey.currentState!.save();
                                await product.save();
                                Navigator.of(context).pop();

                                context.read<ProductManager>().update(product);
                              }else{
                                print("INvalido");
                              }
                            }:(){},
                            style: ButtonStyle(
                              backgroundColor:
                              WidgetStateProperty.all<Color>(
                                  Theme.of(context).primaryColor),
                            ),
                            child: !product.loading ? const Text(
                              "Salvar",
                              style: TextStyle(fontSize: 18,color: Colors.white),
                            ): const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
