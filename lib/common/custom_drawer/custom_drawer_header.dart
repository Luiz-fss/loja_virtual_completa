import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/user_manager.dart';
import 'package:provider/provider.dart';
import 'package:loja_virtual_completa/models/page_manager.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: 180,
      child: Consumer<UserManager>(
        builder: (context,userManager,child){
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Loja do \Luiz",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 34
                ),
              ),
              Text(
                "Olá ${userManager.user?.name ?? ""}",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              GestureDetector(
                onTap: (){
                  if(userManager.isLoggedIn){
                    context.read<PageManager>().setPage(0);
                    userManager.signOut();
                  }else{
                    Navigator.of(context).pushNamed("/login");
                  }
                },
                child: Text(
                  userManager.isLoggedIn ? "Sair" : "Entre ou cadastre-se >",
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
}
