import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual_completa/models/admin_orders_manager.dart';
import 'package:loja_virtual_completa/models/admin_users_manager.dart';
import 'package:loja_virtual_completa/models/page_manager.dart';
import 'package:provider/provider.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Usuários",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: CustomDrawer(),
      body: Consumer<AdminUsersManager>(
        builder: (context, adminUserManager, child) {
          return AlphabetListScrollView(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  adminUserManager.users[index].name ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.w800, color: Colors.white),
                ),
                subtitle: Text(
                  adminUserManager.users[index].email ?? "",
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: (){
                  context.read<AdminOrdersManager>().setUserFilter(
                      adminUserManager.users[index]
                  );
                  context.read<PageManager>().setPage(5);
                },
              );
            },
            indexedHeight: (index) => 80,
            strList: adminUserManager.names,
            showPreview: true,
          );
        },
      ),
    );
  }
}
