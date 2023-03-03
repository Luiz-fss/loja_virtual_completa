import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/componentes-gerais/drawer-customizado.dart';
import 'package:loja_virtual_completa/componentes-gerais/list-tile-produto.dart';
import 'package:loja_virtual_completa/models/gerenciador-produtos.dart';
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
        title: const Text("Produtos"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: ()async{
              final pesquisaUsuario = await
              showDialog(context: context, builder: (context)=> SearchDialog());
              if(pesquisaUsuario != null){
                context.read<GerenciadorProduto>().search = pesquisaUsuario as String;
              }
            },
            icon: const Icon(Icons.search),
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
    );
  }
}
