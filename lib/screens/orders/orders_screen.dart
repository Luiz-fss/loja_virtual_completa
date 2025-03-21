import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual_completa/common/empty_card.dart';
import 'package:loja_virtual_completa/common/login_card.dart';
import 'package:loja_virtual_completa/models/orders_manager.dart';
import 'package:loja_virtual_completa/screens/orders/components/order_tile.dart';
import 'package:provider/provider.dart';


class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text("Meus Pedidos",style: TextStyle(
          color: Colors.white
        ),),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer<OrdersManager>(
        builder: (context,orderManager,child){
          if(orderManager.user == null){
            return LoginCard();
          }
          if(orderManager.orders.isEmpty){
            return EmptyCard(title: "Nenhuma compra encontrada", iconData: Icons.border_clear);
          }
          return ListView.builder(
            itemCount:  orderManager.orders.length,
            itemBuilder: (context,index){
              return OrderTile(
                order:orderManager.orders.reversed.toList()[index]
              );
            },
          );
        },
      ),
    );
  }
}
