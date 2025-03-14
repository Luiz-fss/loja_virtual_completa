import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/main.dart';
import 'package:loja_virtual_completa/models/page_manager.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {
  DrawerTile(
      {super.key,
      required this.iconData,
      required this.title,
      required this.page});

  final IconData iconData;
  final String title;
  final int page;

  @override
  Widget build(BuildContext context) {
    final int currentPage = context.watch<PageManager>().page;
    final Color primaryColor = Theme.of(context).primaryColor;
    return InkWell(
      onTap: () {
        context.read<PageManager>().setPage(page);
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                iconData,
                size: 32,
                color: currentPage == page ? primaryColor : Colors.grey[700],
              ),
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  color: currentPage == page ? primaryColor : Colors.grey[700]),
            )
          ],
        ),
      ),
    );
  }
}
