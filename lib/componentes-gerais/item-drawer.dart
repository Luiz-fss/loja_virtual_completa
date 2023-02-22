import 'package:flutter/material.dart';

class ItemDrawer extends StatelessWidget {
  const ItemDrawer({required this.iconData, required this.titulo, required this.pagina});
  final IconData iconData;
  final String titulo;
  final int pagina;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Icon(
                iconData,
                size: 32,
                color: Colors.grey,
              ),
            ),
            SizedBox(width: 32,),
            Text(
              titulo,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey
              ),
            )
          ],
        ),
      ),
    );
  }
}
