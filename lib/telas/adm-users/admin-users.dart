import 'package:flutter/material.dart';

class AdminUsers extends StatelessWidget {
  const AdminUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Usuários"
        ),
        centerTitle: true,
      ),
    );
  }
}
