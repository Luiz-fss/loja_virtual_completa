import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/componentes-gerais/custom-drawer-header.dart';
import 'package:loja_virtual_completa/componentes-gerais/item-drawer.dart';
import 'package:loja_virtual_completa/models/gerenciador-usuario.dart';
import 'package:provider/provider.dart';

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
                    colors: [Color.fromARGB(255, 203, 236, 241), Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
          ),
          ListView(
            children: [
              CustomDrawerHeader(),
              const Divider(
                height: 1,
              ),
              const ItemDrawer(iconData: Icons.home, titulo: "Início", pagina: 0),
              const ItemDrawer(iconData: Icons.list, titulo: "Produtos", pagina: 1),
              const ItemDrawer(
                iconData: Icons.playlist_add_check,
                titulo: "Meus Pedidos",
                pagina: 2,
              ),
              const ItemDrawer(
                iconData: Icons.location_on,
                titulo: "Lojas",
                pagina: 3,
              ),
              Consumer<GerenciadorUsuario>(
                builder: (_,userManager,__){
                  if(userManager.adminEnabled){
                    return const Column(
                      children: [
                        Divider(),
                        ItemDrawer(
                          iconData: Icons.settings,
                          titulo: "Usuários",
                          pagina: 4,
                        ),
                        ItemDrawer(
                          iconData: Icons.settings,
                          titulo: "Pedidos",
                          pagina: 5,
                        )
                      ],
                    );
                  }else{
                    return Container();
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
