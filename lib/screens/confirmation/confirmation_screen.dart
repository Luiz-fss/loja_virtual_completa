
import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/order.dart';

import '../edit_product/components/order_product_tile.dart';

class ConfirmationScreen extends StatelessWidget {
  final OrderModel order;
  const ConfirmationScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Pedido Confirmado"),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.formattedId,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor
                      ),
                    ),
                    Text(
                      "R\ ${order.price?.toStringAsFixed(2)}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        fontSize: 14
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: order.items!.map((e){
                  return OrderProductTile(cartProduct: e);
                }).toList(),
              )

            ],
          ),
        ),
      ),
    );
  }
}
