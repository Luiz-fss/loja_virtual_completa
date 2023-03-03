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
            onPressed: (){
              showDialog(context: context, builder: (context)=> SearchDialog());
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Consumer<GerenciadorProduto>(
        builder: (_,gerenciadorProduto,child){
          return ListView.builder(
            padding: const EdgeInsets.all(4),
            itemCount: gerenciadorProduto.todosProdutos.length,
            itemBuilder: (context,index){
              return ListTileProduto(produto: gerenciadorProduto.todosProdutos[index]);
            },
          );
        },
      ),
    );
  }
}
