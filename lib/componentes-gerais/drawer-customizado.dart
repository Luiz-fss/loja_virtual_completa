import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/componentes-gerais/custom-drawer-header.dart';
import 'package:loja_virtual_completa/componentes-gerais/item-drawer.dart';

class DrawerCustomizado extends StatelessWidget {
   DrawerCustomizado({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
           Container(
           decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 203, 236, 241),
                  Colors.white
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              )
            ),
          ),
          ListView(
            children:  [
              CustomDrawerHeader(),
              const Divider(height: 1,),
              ItemDrawer(iconData: Icons.home, titulo: "Início",pagina: 0),
              ItemDrawer(iconData: Icons.list, titulo: "Produtos",pagina: 1),
              ItemDrawer(iconData: Icons.playlist_add_check, titulo: "Meus Pedidos",pagina: 2,),
              ItemDrawer(iconData: Icons.location_on, titulo: "Lojas",pagina: 3,),
            ],
          ),
        ],
      ),
    );
  }
}
