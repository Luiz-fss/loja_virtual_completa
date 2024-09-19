import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/componentes-gerais/icon-button-customizado.dart';
import 'package:loja_virtual_completa/models/gerenciador-home.dart';
import 'package:loja_virtual_completa/models/sessao.dart';
import 'package:provider/provider.dart';

class HeaderSessao extends StatelessWidget {

  const HeaderSessao({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<GerenciadorHome>();
    final sessao = context.watch<Sessao>();
    if(homeManager.editing){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: sessao.name,
                  decoration: const InputDecoration(
                    hintText: "Título",
                    isDense: true,
                    border: InputBorder.none
                  ),
                  onChanged: (text){
                    sessao.name = text;
                  },
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800
                  ),
                ),
              ),
              IconButtonCustomizado(
                iconData: Icons.remove,
                corIcone: Colors.white,
                onTap: (){
                  homeManager.removerSection(sessao);
                },
              )
            ],
          ),
          if(sessao.error != null || sessao.error.isNotEmpty)
            Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(sessao.error,style: const TextStyle(color: Colors.red),))
        ],
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        sessao.name ?? "",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w800
        ),
      ),
    );
  }
}
