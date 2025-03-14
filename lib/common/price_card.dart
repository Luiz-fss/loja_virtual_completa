import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/cart_manager.dart';
import 'package:provider/provider.dart';

class PriceCard extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  const PriceCard({super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    final productsPrice = cartManager.productsPrice;
    final deliveryPrice = cartManager.deliveryPrice;
    final totalPrice = cartManager.totalPrice;
    return  Card(
      margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Resumo do pedido",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600
              ),
            ),
            const SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Subtotal"
                ),
                Text(
                  "R\ ${productsPrice.toStringAsFixed(2)}"
                )
              ],
            ),
            const Divider(),
            const SizedBox(height: 12,),
            if(deliveryPrice != null)
              ...[ Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                      "Entrega"
                  ),
                  Text(
                      "R\ ${deliveryPrice.toStringAsFixed(2)}"
                  )
                ],
              ),
                const Divider(),],
            const SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(
                    fontWeight: FontWeight.w500
                  ),
                ),
                Text(
                    "R\ ${totalPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16
                  ),
                )
              ],
            ),
            const SizedBox(height: 8,),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  disabledBackgroundColor: Theme.of(context).primaryColor.withAlpha(100)
              ),
              child: Text(
                buttonText ?? "",
                style: const TextStyle(
                color: Colors.white
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
