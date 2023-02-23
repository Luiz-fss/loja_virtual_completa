import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/gerenciador-usuario.dart';
import 'package:loja_virtual_completa/models/usuario-model.dart';
import 'package:loja_virtual_completa/telas/tela-base.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=> GerenciadorUsuario(),
      child: MaterialApp(
        title: 'Lojinha',
        debugShowCheckedModeBanner: false,
        color:  Color.fromARGB(255, 4, 125, 141),
        theme: ThemeData(
         primaryColor:  Color.fromARGB(255, 4, 125, 141),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor:const Color.fromARGB(255, 4, 125, 141),
          appBarTheme: const AppBarTheme(elevation: 0)
        ),
        home: TelaBase(),
      ),
    );
  }
}
