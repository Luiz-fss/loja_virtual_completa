import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/admin_users_manager.dart';
import 'package:loja_virtual_completa/models/cart_manager.dart';
import 'package:loja_virtual_completa/models/home_manager.dart';
import 'package:loja_virtual_completa/models/order.dart';
import 'package:loja_virtual_completa/models/orders_manager.dart';
import 'package:loja_virtual_completa/models/product.dart';
import 'package:loja_virtual_completa/models/product_manager.dart';
import 'package:loja_virtual_completa/models/user_manager.dart';
import 'package:loja_virtual_completa/screens/address/address_screen.dart';
import 'package:loja_virtual_completa/screens/base/base_screen.dart';
import 'package:loja_virtual_completa/screens/cart/cart_screen.dart';
import 'package:loja_virtual_completa/screens/checkout/checkout_screen.dart';
import 'package:loja_virtual_completa/screens/confirmation/confirmation_screen.dart';
import 'package:loja_virtual_completa/screens/edit_product/edit_product_screen.dart';
import 'package:loja_virtual_completa/screens/login/login_screen.dart';
import 'package:loja_virtual_completa/screens/product/product_screen.dart';
import 'package:loja_virtual_completa/screens/select_product/select_product_screen.dart';
import 'package:loja_virtual_completa/screens/signup/signup_screen.dart';
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
            create: (_)=>UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_)=>HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_)=> ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager,CartManager>(
          create: (_)=>CartManager(),
          lazy: false,
          update: (context,userManager,cartManager) => cartManager!..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager,OrdersManager>(
          create: (_)=>OrdersManager(),
          lazy: false,
          update: (context,userManager,ordersManager) => ordersManager!..updateUser(userManager.user),
        ),
        ChangeNotifierProxyProvider<UserManager,AdminUsersManager>(
          create: (context)=>AdminUsersManager(),
          lazy: false,
          update: (context,userManager,adminUseresManager)=> adminUseresManager!..updateUser(userManager),
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
        //initialRoute: "/base",
        onGenerateRoute: (settings){
          switch(settings.name){
            case "/base":
              return MaterialPageRoute(builder: (_)=>BaseScreen(),settings: settings);
            case "/login":
              return MaterialPageRoute(builder: (_)=>LoginScreen());
            case "/signup":
              return MaterialPageRoute(builder: (_)=>SignupScreen());
            case "/select_product":
              return MaterialPageRoute(builder: (_)=>SelectProductScreen());
            case "/checkout":
              return MaterialPageRoute(builder: (_)=>CheckoutScreen());
            case "/confirmation":
              return MaterialPageRoute(builder: (_)=>ConfirmationScreen(order: settings.arguments as OrderModel));
            case "/address":
              return MaterialPageRoute(builder: (_)=>AddressScreen());
            case "/cart":
              return MaterialPageRoute(builder: (_)=>CartScreen(),settings: settings);
            case "/edit_product":
              return MaterialPageRoute(builder: (_)=>EditProductScreen(
               settings.arguments as Product,
              ));
            case "/product":
              return MaterialPageRoute(builder: (_)=>ProductScreen(product: settings.arguments as Product));
            default: return MaterialPageRoute(builder: (_)=>BaseScreen());
          }
        },

      ),
    );
  }
}
