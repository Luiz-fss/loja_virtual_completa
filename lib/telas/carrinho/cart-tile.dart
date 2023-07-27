import 'package:flutter/material.dart';

import '../../models/produto-cart.dart';

class CartTile extends StatelessWidget {

  ProdutoCart produtoCart;
  CartTile(this.produtoCart);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        child: Row(
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: Image.network(produtoCart.produto?.images!.first ?? ""),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  children: [
                    Text(
                      produtoCart.produto?.name! ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Tamanho: ${produtoCart.tamanho}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Text(
                      "R\$ ${produtoCart.buscarPrecoUnitario?.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
