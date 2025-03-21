import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/cart_product.dart';

class OrderProductTile extends StatelessWidget {
  final CartProduct cartProduct;
  const OrderProductTile({super.key, required this.cartProduct});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed("/product",arguments: cartProduct.product);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: Image.network(cartProduct.product?.images?.first??""),
            ),
            const SizedBox(width: 8,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartProduct.product?.name??"",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17
                    ),
                  ),
                  Text(
                    "Tamanho: ${cartProduct.size}",
                    style: TextStyle(
                      fontWeight: FontWeight.w300
                    ),
                  ),
                  Text(
                    "R\$ ${(cartProduct.fixedPrice ?? cartProduct.unityPrice).toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),
            Text(
                cartProduct.quantity.toString(),
              style: const TextStyle(
                fontSize: 24
              ),
            )
          ],
        ),
      ),
    );
  }
}
