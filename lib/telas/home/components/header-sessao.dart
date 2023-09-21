import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/sessao.dart';

class HeaderSessao extends StatelessWidget {
  final Sessao sessao;
  const HeaderSessao({Key? key, required this.sessao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
