import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/product_manager.dart';
import 'package:provider/provider.dart';

class SelectProductScreen extends StatelessWidget {
  const SelectProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        surfaceTintColor: Colors.white,
        title: const Text("Vincular Produto"),
        centerTitle: true,
      ),
      body: Consumer<ProductManager>(
        builder: (context,productManager,child){
          return ListView.builder(
            itemCount: productManager.allProducts.length,
            itemBuilder: (context,index){
              final product = productManager.allProducts[index];
              return ListTile(
                leading: Image.network(product.images!.first),
                title: Text(product.name!),
                subtitle: Text(
                    "R\$ ${product.basePrice.toStringAsFixed(2)}"),
                onTap: (){
                  Navigator.of(context).pop(product);
                },
              );
            },
          );
        },
      ),
    );
  }
}
