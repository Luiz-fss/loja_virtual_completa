import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/componentes-gerais/drawer-customizado.dart';
import 'package:loja_virtual_completa/models/gerenciador-admin-usuario.dart';
import 'package:provider/provider.dart';

class AdminUsers extends StatelessWidget {
  const AdminUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerCustomizado(),
      appBar: AppBar(
        title: const Text(
          "Usuários"
        ),
        centerTitle: true,
      ),
      body: Consumer<GerenciadorAdminUsuario>(
        builder: (_,gerenciadorAdmUsuario,__){
          return AlphabetListScrollView(
            highlightTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20
            ),
            itemBuilder: (context,index){
              return ListTile(
                title: Text(
                  gerenciadorAdmUsuario.users[index].nomeCompleto!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white
                  ),
                ),
                subtitle: Text(
                  gerenciadorAdmUsuario.users[index].email!,
                  style: const TextStyle(
                      color: Colors.white
                  ),
                ),
              );
            },
            indexedHeight: (index)=> 80,
            strList: gerenciadorAdmUsuario.names,
            showPreview: true,
          );
        },
      ),
    );
  }
}
