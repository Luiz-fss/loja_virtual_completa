import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/order.dart';

class CancelOrderDialog extends StatelessWidget {
  final OrderModel orderModel;
  const CancelOrderDialog({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Cancelar ${orderModel.formattedId} ?"
      ),
      content: const Text(
        "Está ação não poderá ser desfeita",
      ),
      actions: [
        TextButton(
          onPressed: (){
            orderModel.cancel();
            Navigator.of(context).pop();
          },
          child: const Text(
            "Cancelar pedido",
            style: TextStyle(
              color: Colors.red
            ),
          ),
        )
      ],
    );
  }
}
