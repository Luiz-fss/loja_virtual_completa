import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/stores_manager.dart';
import 'package:loja_virtual_completa/screens/stores/components/store_card.dart';
import 'package:provider/provider.dart';

import '../../common/custom_drawer/custom_drawer.dart';

class StoreScreens extends StatelessWidget {
  const StoreScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lojas",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: CustomDrawer(),
      body: Consumer<StoresManager>(
        builder: (contex,storeManager,child){
          if(storeManager.stores!.isEmpty){
            return LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
              backgroundColor: Colors.transparent,
            );
          }
          return ListView.builder(
            itemCount: storeManager.stores!.length,
            itemBuilder: (context,index){
              return StoreCard(store:storeManager.stores![index]);
            },
          );
        },
      ),
    );
  }
}
