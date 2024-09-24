import 'package:flutter/material.dart';

class IconButtonCustomizado extends StatelessWidget {
  const IconButtonCustomizado(
      {Key? key,
      required this.iconData,
      required this.corIcone,
      required this.onTap})
      : super(key: key);

  final IconData iconData;
  final Color corIcone;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Icon(
              iconData,
              color: onTap != null ? corIcone : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
