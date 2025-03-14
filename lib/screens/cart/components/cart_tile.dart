import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/common/custom_icon_button.dart';
import 'package:loja_virtual_completa/models/cart_product.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;
  const CartTile({super.key, required this.cartProduct});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: cartProduct,
      builder: (cart,child){
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
            child: Row(
              children: [
                SizedBox(
                  height: 80,
                  width: 80,
                  child: Image.network(cartProduct.product?.images?.first ?? ""),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            cartProduct.product?.name ?? "",
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "Tamanho: ${cartProduct.size}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w300
                            ),
                          ),
                        ),
                        Consumer<CartProduct>(
                          builder: (context,cartProduct,child){
                            if(cartProduct.hasStock){
                              return Text(
                                "R\$ ${cartProduct.unityPrice.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              );
                            }
                            return const Text(
                              "Sem estoque",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Consumer<CartProduct>(
                  builder: (context,cartProduct,child){
                    return                 Column(
                      children: [
                        CustomIconButton(
                          iconData: Icons.add,
                          color: Theme.of(context).primaryColor,
                          onTap: cartProduct.increment,
                        ),
                        Text(
                          "${cartProduct.quantity}",
                          style: const TextStyle(
                              fontSize: 20
                          ),
                        ),
                        CustomIconButton(
                          iconData: Icons.remove,
                          color: cartProduct.quantity! > 1 ? Theme.of(context).primaryColor: Colors.red,
                          onTap: cartProduct.decrement,
                        )
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
