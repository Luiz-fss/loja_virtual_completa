import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/order.dart';
import 'package:loja_virtual_completa/screens/orders/components/cancel_order_dialog.dart';
import 'package:loja_virtual_completa/screens/orders/components/export_address_dialog.dart';

import '../../edit_product/components/order_product_tile.dart';


class OrderTile extends StatelessWidget {
  final OrderModel order;
  final bool showControls;
  OrderTile({required this.order,this.showControls = false});

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
              order.statusText,
              style:  TextStyle(
                fontWeight: FontWeight.w400,
                color: order.statusText == Status.canceled ? Colors.red :Theme.of(context).primaryColor,
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
          ),
          if(showControls && order.status != Status.canceled)
          SizedBox(
            height: 50,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                TextButton(
                  onPressed: (){
                    showDialog(context: context, builder: (context)=>CancelOrderDialog(
                      orderModel: order,
                    ));
                  },
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(
                      color: Colors.red
                    ),
                  ),
                ),
                TextButton(
                  onPressed: order.back,
                  child: const Text(
                    "Recuar",
                  ),
                ),
                TextButton(
                  onPressed: order.advanced,
                  child: const Text(
                    "Avançar",
                  ),
                ),
                TextButton(
                  onPressed: (){
                    showDialog(context: context, builder: (context)=>ExportAddressDialog(
                      address: order.address,
                    ));
                  },
                  child:  Text(
                    "Endereço",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
