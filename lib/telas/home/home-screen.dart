import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/componentes-gerais/custom-drawer-header.dart';
import 'package:loja_virtual_completa/componentes-gerais/drawer-customizado.dart';
import 'package:loja_virtual_completa/models/gerenciador-home.dart';
import 'package:loja_virtual_completa/models/gerenciador-usuario.dart';
import 'package:loja_virtual_completa/telas/home/components/sessao-list.dart';
import 'package:loja_virtual_completa/telas/home/components/sessao-staggered.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerCustomizado(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 211, 118, 130),
                  Color.fromARGB(255, 253, 181, 168)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              )
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                snap: true,
                floating: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text("Lojinha"),
                  centerTitle: true,
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    color: Colors.white,
                    onPressed: ()=> Navigator.of(context).pushNamed("/tela-carrinho"),
                  ),
                  Consumer2<GerenciadorUsuario,GerenciadorHome>(
                    builder: (context,userManager,homeManager,__){
                      if(userManager.usuarioLogado){
                        if(homeManager.editing){
                          return PopupMenuButton(
                            onSelected: (e){
                              if(e=="Salvar"){
                                homeManager.saveEditing();
                              }else{
                                homeManager.descardEditing();
                              }
                            },
                            itemBuilder: (_){
                              return ["Salvar", "Descartar"].map((e){
                                return PopupMenuItem(
                                  child: Text(e),
                                  value: e,
                                );
                              }).toList();
                            },
                          );
                        }
                        return IconButton(
                          icon: const Icon(Icons.shopping_cart),
                          color: Colors.white,
                          onPressed: homeManager.enterEditing,
                        );
                      }else{
                        return Container();
                      }
                    },
                  ),
                ],
              ),
              Consumer<GerenciadorHome>(
                builder: (_,homeManager,__){
                  final List<Widget> children = homeManager.sessoes.map((sessao){
                    switch(sessao.type){
                      case "List":
                        return SessaoLista(sessao: sessao,);
                      case "Staggered":
                        return SessaoStaggered(sessao: sessao);
                      default:
                        return Container();
                    }
                  }).toList();
                  return SliverList(
                    delegate: SliverChildListDelegate(
                        children
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
