import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/componentes-gerais/drawer-customizado.dart';
import 'package:loja_virtual_completa/models/gerenciador-paginas.dart';
import 'package:loja_virtual_completa/models/gerenciador-usuario.dart';
import 'package:loja_virtual_completa/telas/adm-users/admin-users.dart';
import 'package:loja_virtual_completa/telas/home/home-screen.dart';
import 'package:loja_virtual_completa/telas/login/tela-login.dart';
import 'package:loja_virtual_completa/telas/produtos/listagem-produtos.dart';
import 'package:provider/provider.dart';

class TelaBase extends StatefulWidget {

   TelaBase({Key? key}) : super(key: key);

  @override
  State<TelaBase> createState() => _TelaBaseState();
}

class _TelaBaseState extends State<TelaBase> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return  Provider(
      create: (_)=> GerenciadorPaginas(_pageController),
      child: Consumer<GerenciadorUsuario>(
        builder: (_,userManager,__){
          return PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              HomeScreen(),
              ListagemProdutos(),
              Scaffold(
                drawer: DrawerCustomizado(),
                appBar: AppBar(
                  backgroundColor:  const Color.fromARGB(255, 4, 125, 141),
                  title: Text("Home3"),
                ),
              ),
              Scaffold(
                drawer: DrawerCustomizado(),
                appBar: AppBar(
                  backgroundColor:  const Color.fromARGB(255, 4, 125, 141),
                  title: Text("Home4"),
                ),
              ),
              if(userManager.adminEnabled)
                ...[
                  AdminUsers(),
                  Scaffold(
                    drawer: DrawerCustomizado(),
                    appBar: AppBar(
                      backgroundColor:  const Color.fromARGB(255, 4, 125, 141),
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
