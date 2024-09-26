import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/gerenciador-home.dart';
import 'package:loja_virtual_completa/models/section.dart';
import 'package:provider/provider.dart';

class AddSectionWidget extends StatelessWidget {
  const AddSectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<GerenciadorHome>();
    return  Row(
      children: [
        Expanded(
          child: TextButton(
            child: const Text("Adicionar Lista",style: TextStyle(color: Colors.white),),
            onPressed: (){
              homeManager.addSection(Section(type: "List"));
            },
          ),
        ),
        Expanded(
          child: TextButton(
            child: const Text("Adicionar Grade",style: TextStyle(color: Colors.white),),
            onPressed: (){
              homeManager.addSection(Section(type: "Staggered"));
            },
          ),
        )
      ],
    );
  }
}
