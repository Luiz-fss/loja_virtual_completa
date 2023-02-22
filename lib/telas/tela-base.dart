import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/componentes-gerais/drawer-customizado.dart';

class TelaBase extends StatelessWidget {
   TelaBase({Key? key}) : super(key: key);

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return  PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          Scaffold(
            drawer: DrawerCustomizado(),
            appBar: AppBar(
              title: Text("Home"),
            ),
          )
        ],
    );
  }
}
