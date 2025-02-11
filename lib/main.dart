import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/gerenciador-admin-usuario.dart';
import 'package:loja_virtual_completa/models/cart-manager.dart';
import 'package:loja_virtual_completa/models/gerenciador-home.dart';
import 'package:loja_virtual_completa/models/gerenciador-produtos.dart';
import 'package:loja_virtual_completa/models/gerenciador-usuario.dart';
import 'package:loja_virtual_completa/models/product.dart';
import 'package:loja_virtual_completa/models/usuario-model.dart';
import 'package:loja_virtual_completa/telas/address/address-screen.dart';
import 'package:loja_virtual_completa/telas/carrinho/tela-carrinho.dart';
import 'package:loja_virtual_completa/telas/checkout/checkout-screen.dart';
import 'package:loja_virtual_completa/telas/login/cadastro-conta.dart';
import 'package:loja_virtual_completa/telas/login/tela-login.dart';
import 'package:loja_virtual_completa/telas/produtos/product-screen.dart';
import 'package:loja_virtual_completa/telas/produtos/editar-produto.dart';
import 'package:loja_virtual_completa/telas/tela-base.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_)=> GerenciadorUsuario(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<GerenciadorUsuario,CartManager>(
          create: (_)=> CartManager(),
          lazy: false,
          update: (contex,gerenciadorUsuario,gerenciadorCarrinho){
            return gerenciadorCarrinho!..updateUser(gerenciadorUsuario);
          },
        ),
        ChangeNotifierProxyProvider<GerenciadorUsuario,GerenciadorAdminUsuario>(
          create: (_)=> GerenciadorAdminUsuario(),
          lazy: false,
          update: (context,userManager,admUserManager) => admUserManager!..updateUser(userManager),
        ),
        ChangeNotifierProvider(create: (_)=>GerenciadorHome(),lazy: false,),
        ChangeNotifierProvider(
          create: (_)=> GerenciadorProduto(),
          lazy: false,
        )
      ],
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
        initialRoute: "/tela-base",
        onGenerateRoute: (settings){
          switch(settings.name){
            case "/tela-base":
              return MaterialPageRoute(builder: (_)=>TelaBase());
            case "/checkout":
              return MaterialPageRoute(builder: (_)=>CheckoutScreen());
            case "/address-screen":
              return MaterialPageRoute(builder: (_)=>AddressScreen());
            case "/cadastro-conta":
              return MaterialPageRoute(builder: (_)=> CadastroConta());
            case "/tela-login":
              return MaterialPageRoute(builder: (_)=> TelaLogin());
            case "/tela-carrinho":
              return MaterialPageRoute(builder: (_)=> TelaCarrinho());
            case "/detalhe-produto":
              return MaterialPageRoute(builder: (_)=> ProductScreen(
                settings.arguments as Product
              ));
            case "/editar-produto":
              return MaterialPageRoute(builder: (_)=>EditarProduto(
                settings.arguments as Product,
              ));
            default:
              return MaterialPageRoute(builder: (_)=>TelaBase());
          }
        },
      )
    );
  }
}
