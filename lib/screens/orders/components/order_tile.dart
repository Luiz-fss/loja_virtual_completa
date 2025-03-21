import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/order.dart';

import '../../edit_product/components/order_product_tile.dart';


class OrderTile extends StatelessWidget {
  final OrderModel order;
  const OrderTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 14
                  ),
                )
              ],
            ),

            Text(
              "Em transporte",
              style:  TextStyle(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).primaryColor,
                fontSize: 14
              ),
            )
          ],
        ),
        children: [
          Column(
            children: order.items!.map((e){
              return OrderProductTile(cartProduct: e);
            }).toList(),
          )
        ],
      ),
    );
  }
}
