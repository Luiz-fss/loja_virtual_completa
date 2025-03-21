import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual_completa/common/custom_icon_button.dart';
import 'package:loja_virtual_completa/common/empty_card.dart';
import 'package:loja_virtual_completa/common/login_card.dart';
import 'package:loja_virtual_completa/models/admin_orders_manager.dart';
import 'package:loja_virtual_completa/screens/orders/components/order_tile.dart';
import 'package:provider/provider.dart';

class AdminOrdersScreen extends StatelessWidget {
  const AdminOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text(
          "Todos os Pedidos",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer<AdminOrdersManager>(
        builder: (context, orderManager, child) {
          final filteredOrders = orderManager.filteredOrders;

          return Column(
            children: [
              if (orderManager.userFilter != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 2),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Pedidos de ${orderManager.userFilter?.name}",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, color: Colors.white),
                        ),
                      ),
                      CustomIconButton(
                        iconData: Icons.close,
                        color: Colors.white,
                        onTap: () {
                          orderManager.setUserFilter(null);
                        },
                      )
                    ],
                  ),
                ),
              if (filteredOrders.isEmpty)
                const Expanded(
                  child: EmptyCard(
                      title: "Nenhuma venda realizada",
                      iconData: Icons.border_clear),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      return OrderTile(
                        order: filteredOrders.reversed.toList()[index],
                        showControls: true,
                      );
                    },
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
