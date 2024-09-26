import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/product.dart';

class ListTileProduto extends StatelessWidget {
  ListTileProduto({Key? key, required this.produto}) : super(key: key);

  final Product produto;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed("/detalhe-produto",arguments: produto);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)
        ),
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(produto.images!.first),
              ),
              SizedBox(width: 16,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      produto.name!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        "A partir de:",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Text(
                      "R\$ ${produto.basePrice.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor
                      ),
                    ),
                    if(!produto.hasStock)
                      const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          'Sem estoque',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 10
                          ),
                        ),
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
