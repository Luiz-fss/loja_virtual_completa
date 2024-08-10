import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/gerenciador-produtos.dart';
import 'package:provider/provider.dart';

class SelectProductScreen extends StatelessWidget {
  const SelectProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Vincular Produto"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Consumer<GerenciadorProduto>(
        builder: (_,productManager,__){
          return ListView.builder(
            itemCount: productManager.todosProdutos.length,
            itemBuilder: (context,index){
              final product =productManager.todosProdutos[index];
              return ListTile(
                title: Text(product.name!),
                onTap: (){
                  Navigator.of(context).pop(product);
                },
                leading: Image.network(product.images!.first),
                subtitle: Text("R\$ ${product.basePrice.toStringAsFixed(2)}"),
              );
            },
          );
        },
      ),
    );
  }
}
