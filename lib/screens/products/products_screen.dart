import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual_completa/models/product.dart';
import 'package:loja_virtual_completa/models/product_manager.dart';
import 'package:loja_virtual_completa/models/user_manager.dart';
import 'package:loja_virtual_completa/screens/products/components/product_list_tile.dart';
import 'package:provider/provider.dart';

import 'components/search_dialog.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<ProductManager>(
          builder: (context, productManager, child) {
            if (productManager.search.isEmpty) {
              return const Text(
                "Produtos",
                style: TextStyle(color: Colors.white),
              );
            }
            return LayoutBuilder(
              builder: (context,constraints){
                constraints.biggest.width;
                return GestureDetector(
                    onTap: () async{
                      final search = await showDialog<String>(
                          context: context, builder: (context) => SearchDialog(
                        initialText: productManager.search,
                      ));
                      if (search != null) {
                        productManager.search = search;
                      }
                    },
                    child: Container(
                      width:  constraints.biggest.width,
                      child: Text(
                        productManager.search,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ));
              },
            );
          },
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          Consumer<ProductManager>(
            builder: (_, productManager, child) {
              if (productManager.search.isEmpty) {
                return IconButton(
                  onPressed: () async {
                    final search = await showDialog<String>(
                        context: context, builder: (context) => SearchDialog(
                      initialText: productManager.search,
                    ));
                    if (search != null) {
                      productManager.search = search;
                    }
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                );
              }
              return IconButton(
                onPressed: () async {
                  productManager.search = "";
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              );
            },
          ),
          Consumer<UserManager>(
            builder: (context,userManager,child){
              if(userManager.adminEnable){
                return IconButton(
                  icon: Icon(Icons.add,color: Colors.white,),
                  onPressed: (){
                    Navigator.of(context).pushNamed("/edit_product",arguments: Product());
                  },
                );
              }
              return Container();
            },
          )
        ],
      ),
      drawer: CustomDrawer(),
      body: Consumer<ProductManager>(
        builder: (context, productManager, child) {
          final filteredProducts = productManager.filteredProducts;
          return ListView.builder(
            padding: const EdgeInsets.all(4),
            itemCount: filteredProducts.length ?? 0,
            itemBuilder: (context, index) {
              return ProductListTile(product: filteredProducts[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        onPressed: (){
          Navigator.of(context).pushNamed("/cart");
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
