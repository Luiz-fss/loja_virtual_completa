import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/common/custom_drawer/custom_drawer_header.dart';
import 'package:loja_virtual_completa/common/custom_drawer/drawer_tile.dart';
import 'package:loja_virtual_completa/models/user_manager.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                const Color.fromARGB(255, 203, 236, 241),
                Colors.white
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
            ),

          ),
          ListView(
            children: [
              CustomDrawerHeader(),
              const Divider(),
              DrawerTile(
                iconData: Icons.home,
                title: "Início",
                page: 0,
              ),
              DrawerTile(
                iconData: Icons.list,
                title: "Produtos",
                page: 1,
              ),
              DrawerTile(
                iconData: Icons.playlist_add_check,
                title: "Meus Pedidos",
                page: 2,
              ),
              DrawerTile(
                iconData: Icons.location_on,
                title: "Lojas",
                page: 3,
              ),
              Consumer<UserManager>(
                builder: (context,userManager,child){
                  if(userManager.adminEnable){
                    return Column(
                      children: [
                        const Divider(),
                        DrawerTile(
                          iconData: Icons.settings,
                          title: "Usuários",
                          page: 4,
                        ),
                        DrawerTile(
                          iconData: Icons.settings,
                          title: "Pedidos",
                          page: 5,
                        )
                      ],
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
