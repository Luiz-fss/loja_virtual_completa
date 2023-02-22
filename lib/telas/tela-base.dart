import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/componentes-gerais/drawer-customizado.dart';
import 'package:loja_virtual_completa/models/gerenciador-paginas.dart';
import 'package:provider/provider.dart';

class TelaBase extends StatelessWidget {
   TelaBase({Key? key}) : super(key: key);

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return  Provider(
      create: (_)=> GerenciadorPaginas(_pageController),
      child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            Scaffold(
              drawer: DrawerCustomizado(),
              appBar: AppBar(
                title: Text("Home"),
              ),
            ),
            Scaffold(
              drawer: DrawerCustomizado(),
              appBar: AppBar(
                title: Text("Home2"),
              ),
            ),
            Scaffold(
              drawer: DrawerCustomizado(),
              appBar: AppBar(
                title: Text("Home3"),
              ),
            ),
            Scaffold(
              drawer: DrawerCustomizado(),
              appBar: AppBar(
                title: Text("Home4"),
              ),
            ),
          ],
      ),
    );
  }
}
