import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/componentes-gerais/icon-button-customizado.dart';
import 'package:provider/provider.dart';

import '../../models/cart-product.dart';

class CartTile extends StatelessWidget {
  CartProduct produtoCart;
  CartTile(this.produtoCart);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: produtoCart,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: Image.network(produtoCart.product?.images!.first ?? ""),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        produtoCart.product?.name! ?? "",
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Tamanho: ${produtoCart.size}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Consumer<CartProduct>(
                        builder: (_, produtoCart, __) {
                          if (produtoCart.hasStock) {
                            return Text(
                              "R\$ ${produtoCart.unitPrice?.toStringAsFixed(2)}",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            );
                          } else {
                            return Text(
                              "Sem estoque suficiente.",
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
              Consumer<CartProduct>(
                builder: (context, produtoCart, __) {
                  return Column(
                    children: [
                      IconButtonCustomizado(
                          iconData: Icons.add,
                          corIcone: Theme.of(context).primaryColor,
                          onTap: produtoCart.increment),
                      Text(
                        "${produtoCart.quantity}",
                        style: const TextStyle(fontSize: 20),
                      ),
                      IconButtonCustomizado(
                          iconData: Icons.remove,
                          corIcone: produtoCart.quantity != null &&
                                  produtoCart.quantity! > 1
                              ? Theme.of(context).primaryColor
                              : Colors.red,
                          onTap: produtoCart.decrement),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
