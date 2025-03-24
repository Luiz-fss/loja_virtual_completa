import 'package:banner_carousel/banner_carousel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/cart_manager.dart';
import 'package:loja_virtual_completa/models/product.dart';
import 'package:loja_virtual_completa/models/product_manager.dart';
import 'package:loja_virtual_completa/models/user_manager.dart';
import 'package:loja_virtual_completa/screens/product/components/size_widget.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  final Product product;
  const ProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final primaryColor =  Theme.of(context).primaryColor;
    return  ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            product.name ?? "",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Consumer<UserManager>(
              builder: (context,userManager,child){
                if(userManager.adminEnable && !product.deleted!){
                  return IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: (){
                      Navigator.of(context).pushReplacementNamed("/edit_product",arguments: product);
                    },
                  );
                }
                return Container();
              },
            ),
          ],
          centerTitle: true,
        ),
        body: ListView(
          children: [
            BannerCarousel(
              activeColor: Colors.amber,
              width: 250,
              height: 400,
              animation: true,
              borderRadius: 25,
              customizedBanners: product.images!.map((url)
              =>Image.network(url,fit: BoxFit.cover,)).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    product.name ?? "",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "A partir de",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600]
                      ),
                    ),
                  ),
                  Text(
                    "R\$ ${product.basePrice.toStringAsFixed(2)}",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: primaryColor
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16,bottom: 8),
                    child: Text(
                      "Descrição",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  Text(
                    product.description ?? "",
                    style: const TextStyle(
                        fontSize: 16
                    ),
                  ),

                  if(product.deleted!)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8,top: 16),
                      child: Text("Indisponível",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.red
                      ),),
                    )
                  else
                 ...[
                   const Padding(
                     padding: EdgeInsets.only(top: 16,bottom: 8),
                     child: Text(
                       "Tamanhos",
                       style: TextStyle(
                           fontSize: 16,
                           fontWeight: FontWeight.w500
                       ),
                     ),
                   ),
                   Wrap(
                     spacing: 8,
                     runSpacing: 8,
                     children: product.sizes!.map((s)=>SizeWidget(size:s)).toList(),
                   ),
                 ],
                  const SizedBox(height: 20,),
                  if(product.hasStock)
                    Consumer2<UserManager, Product>(
                      builder: (context,userManager,productManager,child){
                        return SizedBox(
                          height: 44,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                surfaceTintColor: Theme.of(context).primaryColor.withAlpha(100)
                            ),
                            onPressed: product.selectedSize != null ? (){
                              if(userManager.isLoggedIn){
                                context.read<CartManager>().addToCart(product);
                                Navigator.of(context).pushNamed("/cart");
                              }else{
                                Navigator.of(context).pushNamed("/login");
                              }

                            }:null,
                            child: Text(
                              userManager.isLoggedIn ?
                              "Adicionar ao Carrinho":
                              "Entre para comprar",
                              style:  const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18
                              ),
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
    );
  }
}
