import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/common/custom_icon_button.dart';
import 'package:loja_virtual_completa/models/home_manager.dart';
import 'package:loja_virtual_completa/models/section.dart';
import 'package:provider/provider.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key,});

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    final section = context.watch<Section>();

    if(homeManager.editing){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: section.name ?? "",
                  decoration: const InputDecoration(
                    hintText: "Título",
                    isDense: true,
                    border: InputBorder.none
                  ),
                  onChanged: (text)=>section.name = text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800
                  ),
                ),
              ),
              CustomIconButton(
                iconData: Icons.remove,
                color: Colors.white,
                onTap: (){
                  homeManager.removeSection(section);
                },
              )
            ],
          ),
          if(section.error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                section.error ?? "",
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold
                ),
              ),
            )

        ],
      );
    }else{}
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        section.name ?? "",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w800
        ),
      ),
    );
  }
}
