import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/componentes-gerais/icon-button-customizado.dart';
import 'package:loja_virtual_completa/models/produto.dart';
import 'package:loja_virtual_completa/models/tamanho-item.dart';
import 'package:loja_virtual_completa/telas/produtos/components/edit_item_size.dart';

class SizesForm extends StatelessWidget {
  final Produto product;
  const SizesForm({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<List<TamanhoItem>>(
      initialValue: List.from(product.tamanhos),
      builder: (state) {
        return Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Tamanhos",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                IconButtonCustomizado(
                    iconData: Icons.add,
                    corIcone: Colors.black,
                    onTap: () {
                      state.value?.add(TamanhoItem());
                      state.didChange(state.value);
                    }
                )
              ],
            ),
            Column(
              children: state.value!.map((size) {
                return EditItemSize(
                  size: size,
                  onRemove: (){
                    state.value?.remove(size);
                    state.didChange(state.value);
                  },
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
