import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/address.dart';
import 'package:loja_virtual_completa/models/order.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:screenshot/screenshot.dart';

class ExportAddressDialog extends StatelessWidget {
  final Address? address;
   ExportAddressDialog({super.key, required this.address});

  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Endereço de entrega",

      ),
      content: Screenshot(
        controller: screenshotController,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(8),
          child: Text(
            "${address?.street}, ${address?.number}, ${address?.complement}, \n"
                "${address?.district}, \n"
                "${address?.city}, ${address?.state}, \n"
                "${address?.zipCode},"
          ),
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
      actions: [
        TextButton(
          onPressed: ()async{

            final file = await screenshotController.capture();
            await SaverGallery.saveImage(file!, fileName: "address_screen ${address?.street}", skipIfExists: false);
            Navigator.of(context).pop();
          },
          child: Text(
            "Exportar",
            style: TextStyle(
              color: Theme.of(context).primaryColor
            ),
          ),
        )
      ],
    );
  }
}
