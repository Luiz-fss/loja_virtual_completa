import 'package:flutter/material.dart';

import 'components/address-card.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrega"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AddressCard()
        ],
      ),
    );
  }
}
