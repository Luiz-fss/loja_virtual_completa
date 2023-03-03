import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  const SearchDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 2,
          left: 4,
          right: 4,
          child: Card(
            child: TextFormField(
              textInputAction: TextInputAction.search,
              decoration:  InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                prefixIcon: IconButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back),
                )
              ),
              autofocus: true,
              onFieldSubmitted: (textoPesquisa){
                Navigator.of(context).pop(textoPesquisa);
              },
            ),
          ),
        )
      ],
    );
  }
}
