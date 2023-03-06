import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/produto.dart';
import 'package:loja_virtual_completa/telas/produtos/item-tamanho.dart';
import 'package:provider/provider.dart';

class DetalheProduto extends StatelessWidget {

  final Produto produto;
  DetalheProduto(this.produto);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: produto,
      child: Scaffold(
        backgroundColor:  Colors.white,
        appBar: AppBar(
          backgroundColor:  const Color.fromARGB(255, 4, 125, 141),
          centerTitle: true,
          title: Text(
            produto.name!
          ),
        ),
        body: ListView(
          
          children: [
           BannerCarousel(
             customizedBanners:_retornarImagens(),
             activeColor: Colors.amber,
             width: 250,
             height: 250,
             animation: true,
             borderRadius: 25,
           ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    produto.name!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      "A partir de:",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13
                      ),
                    ),
                  ),
                  Text(
                    "R\$ 19,99,",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor
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
                    produto.description!,
                    style: const TextStyle(
                      fontSize: 16
                    ),
                  ),
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
                    children: produto.tamanhos!.map((w){
                      return ItemTamanho(w);
                    }).toList(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _retornarImagens(){
    List<Widget> listaImgs = [];
    for(int i =0;i < produto.images!.length;i++){
     listaImgs.add(Image.network(produto.images![i]));
    }
    return listaImgs;
  }
}
