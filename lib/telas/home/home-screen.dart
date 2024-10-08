import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/componentes-gerais/custom-drawer-header.dart';
import 'package:loja_virtual_completa/componentes-gerais/drawer-customizado.dart';
import 'package:loja_virtual_completa/models/gerenciador-home.dart';
import 'package:loja_virtual_completa/models/gerenciador-usuario.dart';
import 'package:loja_virtual_completa/telas/home/components/add-section-widget.dart';
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
                      if(userManager.usuarioLogado && !homeManager.loading){
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
                          icon: const Icon(Icons.edit),
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
                  if(homeManager.loading){
                    return SliverToBoxAdapter(
                      child: LinearProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                        backgroundColor: Colors.transparent,
                      ),
                    );
                  }
                  final List<Widget> children = homeManager.sections.map((sessao){
                    switch(sessao.type){
                      case "List":
                        return SessaoLista(sessao);
                      case "Staggered":
                        return SessaoStaggered(sessao);
                      default:
                        return Container();
                    }
                  }).toList();
                  children.add(_buildAddItems(homeManager));
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

  Widget _buildAddItems(GerenciadorHome homeManager){
    if(homeManager.editing){
     return AddSectionWidget();
    }
    return Container();
  }
}
