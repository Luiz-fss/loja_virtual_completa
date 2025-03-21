import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual_completa/models/page_manager.dart';
import 'package:loja_virtual_completa/models/user_manager.dart';
import 'package:loja_virtual_completa/screens/admin_users/admin_users_screen.dart';
import 'package:loja_virtual_completa/screens/home/home_screen.dart';
import 'package:loja_virtual_completa/screens/login/login_screen.dart';
import 'package:loja_virtual_completa/screens/orders/orders_screen.dart';
import 'package:loja_virtual_completa/screens/products/products_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
   BaseScreen({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return  Provider(
      create: (_)=>PageManager(_pageController),
      child: Consumer<UserManager>(
        builder: (contex,userManager,child){
          return PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              HomeScreen(),
              ProductsScreen(),
              OrdersScreen(),
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: Text("data"),
                ),
              ),
              if(userManager.adminEnable)...[
                AdminUsersScreen(),
                Scaffold(
                  drawer: CustomDrawer(),
                  appBar: AppBar(
                    title: Text("Pedidos"),
                  ),
                )
              ]
            ],
          );
        },
      ),
    );
  }
}
