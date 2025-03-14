import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual_completa/models/home_manager.dart';
import 'package:loja_virtual_completa/models/user_manager.dart';
import 'package:loja_virtual_completa/screens/home/components/section_list.dart';
import 'package:provider/provider.dart';

import 'components/add_section_widget.dart';
import 'components/section_staggered.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
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
                elevation: 0,
                backgroundColor: Colors.transparent,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text(
                      "Loja do Luiz",
                      style: TextStyle(
                        color: Colors.white
                      ),
                  ),
                  centerTitle: true,
                ),
                actions: [
                  IconButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed("/cart");
                    },
                    icon: const Icon(Icons.shopping_cart,color: Colors.white,),
                  ),
                  Consumer2<UserManager,HomeManager>(
                    builder: (context,userManager,homeManager,child){
                      if(userManager.adminEnable && !homeManager.loading){
                        if(homeManager.editing){
                          return PopupMenuButton(
                            color: Colors.white,
                            iconColor: Colors.white,
                            onSelected: (e){
                              if(e == "Salvar"){
                                homeManager.saveEditing();
                              }else{
                                homeManager.discardEditing();
                              }
                            },
                            itemBuilder: (context){
                              return ["Salvar", "Descartar"].map((e){
                                return PopupMenuItem(
                                  child: Text(e),
                                  value: e,
                                );
                              }).toList();
                            },
                          );
                        }else{
                          return IconButton(
                            icon: const Icon(Icons.edit,color: Colors.white,),
                            onPressed: (){
                              homeManager.enterEditing();
                            },
                          );
                        }
                      }
                      return Container();
                    },

                  )
                ],
              ),
              Consumer<HomeManager>(
                builder: (context,homeManager,child){
                  if(homeManager.loading){

                    return  const SliverToBoxAdapter(
                        child: LinearProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                          backgroundColor: Colors.transparent,
                        )
                    );
                  }
                  final List<Widget> children = homeManager.sections.map((section){
                    switch(section.type){
                      case "List":
                        return SectionList(section:section);
                      case "Staggered":
                        return SectionStaggered(section:section);
                      default:
                        return Container();
                    }
                  }).toList();
                  if(homeManager.editing)
                    children.add(AddSectionWidget());
                  return SliverList(
                    delegate: SliverChildListDelegate(
                      children
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
