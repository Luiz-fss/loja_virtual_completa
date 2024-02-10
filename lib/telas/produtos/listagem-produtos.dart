import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/componentes-gerais/drawer-customizado.dart';
import 'package:loja_virtual_completa/componentes-gerais/list-tile-produto.dart';
import 'package:loja_virtual_completa/models/gerenciador-produtos.dart';
import 'package:loja_virtual_completa/models/gerenciador-usuario.dart';
import 'package:loja_virtual_completa/telas/produtos/search-dialog.dart';
import 'package:provider/provider.dart';

class ListagemProdutos extends StatelessWidget {
  const ListagemProdutos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerCustomizado(),
      appBar: AppBar(
        backgroundColor:  const Color.fromARGB(255, 4, 125, 141),
        title: Consumer<GerenciadorProduto>(
          builder: (_,gerenciadorProd,child){
            if(gerenciadorProd.pesquisa.isEmpty){
              return const Text("Produtos");
            }else{
              return LayoutBuilder(
                builder: (context,constraints){
                  return GestureDetector(
                    child: Container(
                        width: constraints.biggest.width,
                        child: Text(gerenciadorProd.pesquisa)
                    ),
                    onTap: ()async{
                      final pesquisaUsuario = await
                      showDialog(context: context, builder: (context)=> SearchDialog(gerenciadorProd.pesquisa));
                      if(pesquisaUsuario != null){
                        gerenciadorProd.search = pesquisaUsuario as String;
                      }
                    },
                  );
                },
              );
            }
          },
        ),
        centerTitle: true,
        actions: [
          Consumer<GerenciadorProduto>(
            builder: (context,gerenciadorProduto,child){
              if(gerenciadorProduto.pesquisa.isEmpty){
                return
                  IconButton(
                    onPressed: ()async{
                      final pesquisaUsuario = await
                      showDialog(context: context, builder: (context)=> SearchDialog(gerenciadorProduto.pesquisa));
                      if(pesquisaUsuario != null){
                        gerenciadorProduto.search = pesquisaUsuario as String;
                      }
                    },
                    icon: const Icon(Icons.search),
                  );

              }else{
                return
                  IconButton(
                    onPressed: ()async{
                     gerenciadorProduto.pesquisa = "";
                    },
                    icon: const Icon(Icons.close),
                  );
              }
            },
          ),
          Consumer<GerenciadorUsuario>(
            builder: (_, userManager, __) {
              if (userManager.adminEnabled) {
                return IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                        "/editar-produto",);
                  },
                  icon: Icon(Icons.add),
                );
              } else {
                return Container();
              }
            },
          )

        ],
      ),
      body: Consumer<GerenciadorProduto>(
        builder: (_,gerenciadorProduto,child){
          final prodFiltado = gerenciadorProduto.filtrarListaProduto;
          return ListView.builder(
            padding: const EdgeInsets.all(4),
            itemCount: prodFiltado.length,
            itemBuilder: (context,index){
              return ListTileProduto(produto: prodFiltado[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        onPressed: (){
          Navigator.of(context).pushNamed("/tela-carrinho");
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
