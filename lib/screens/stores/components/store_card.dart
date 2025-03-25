import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/store.dart';

import '../../../common/custom_icon_button.dart';

class StoreCard extends StatelessWidget {
  final Store store;
  const StoreCard({super.key, required this.store});

  @override
  Widget build(BuildContext context) {

    Color colorForStatus(StoreStatus status){
      switch(status){
        case StoreStatus.closed:
          return Colors.red;
        case StoreStatus.open:
          return Colors.green;
        case StoreStatus.closing:
         return Colors.yellow;
      }
    }
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            height: 160,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(store.image ?? "",fit: BoxFit.cover,),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: const BorderRadius.only(
                       bottomLeft: Radius.circular(8)
                     )
                   ),
                    child: Text(
                      store.statusText,
                      style: TextStyle(
                        color: colorForStatus(store.status ?? StoreStatus.open),
                        fontSize: 16,
                        fontWeight: FontWeight.w800
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 140,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        store.name??"",
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 17
                        ),
                      ),
                      Text(
                        store.addressText,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        store.openingText,
                        style: const TextStyle(
                          fontSize: 12
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIconButton(
                      iconData: Icons.map,
                      onTap: (){},
                      color: Theme.of(context).primaryColor,
                    ),
                    CustomIconButton(
                      iconData: Icons.phone,
                      onTap: (){},
                      color: Theme.of(context).primaryColor,
                    )

                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
