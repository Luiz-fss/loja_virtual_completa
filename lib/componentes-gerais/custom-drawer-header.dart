import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/gerenciador-paginas.dart';
import 'package:loja_virtual_completa/models/gerenciador-usuario.dart';
import 'package:provider/provider.dart';

class CustomDrawerHeader extends StatelessWidget {
  CustomDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: 180,
      child: Consumer<GerenciadorUsuario>(
        builder: (_,gerenciadorUsuario,child){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:  [
              const Text(
                "Lojinha",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "Olá, ${gerenciadorUsuario.usuarioAtual?.nomeCompleto ?? ''}",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              GestureDetector(
                onTap: (){
                  if(gerenciadorUsuario.usuarioLogado){
                    context.read<GerenciadorPaginas>().setPage(0);
                    gerenciadorUsuario.signOut();
                  }else{
                    Navigator.pushNamed(context, "/tela-login");
                  }
                },
                child: Text(
                 _retornarNomeUsuarioLogado(gerenciadorUsuario),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  String _retornarNomeUsuarioLogado(GerenciadorUsuario gerenciadorUsuario){
    if( gerenciadorUsuario.usuarioLogado != null && gerenciadorUsuario.usuarioLogado){
      return "Sair";
    }else{
      return "Entre ou cadastre-se >";
    }
  }
}
