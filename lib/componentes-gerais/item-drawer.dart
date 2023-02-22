import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/gerenciador-paginas.dart';
import 'package:provider/provider.dart';

class ItemDrawer extends StatelessWidget {
  const ItemDrawer({required this.iconData, required this.titulo, required this.pagina});
  final IconData iconData;
  final String titulo;
  final int pagina;

  @override
  Widget build(BuildContext context) {
    final int paginaAtual = context.watch<GerenciadorPaginas>().paginaAtual;

    return InkWell(
      onTap: (){
        context.read<GerenciadorPaginas>().setPage(pagina);
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Icon(
                iconData,
                size: 32,
                color: _retornarCorItemSelecionado(paginaAtual),
              ),
            ),
            SizedBox(width: 32,),
            Text(
              titulo,
              style:  TextStyle(
                fontSize: 16,
                color: _retornarCorItemSelecionado(paginaAtual)
              ),
            )
          ],
        ),
      ),
    );
  }

  Color _retornarCorItemSelecionado(int paginaAtual){
    if(paginaAtual == pagina){
      return Colors.red;
    }else{
      return Colors.grey;
    }
  }
}
