import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/componentes-gerais/icon-button-customizado.dart';
import 'package:loja_virtual_completa/models/gerenciador-home.dart';
import 'package:loja_virtual_completa/models/sessao.dart';
import 'package:provider/provider.dart';

class HeaderSessao extends StatelessWidget {
  final Sessao sessao;
  const HeaderSessao({Key? key, required this.sessao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<GerenciadorHome>();
    if(homeManager.editing){
      return Row(
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
