import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/componentes-gerais/icon-button-customizado.dart';
import 'package:loja_virtual_completa/models/produto.dart';
import 'package:loja_virtual_completa/models/item-size.dart';
import 'package:loja_virtual_completa/telas/produtos/components/edit_item_size.dart';

class SizesForm extends StatelessWidget {
  final Produto product;
  const SizesForm({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemSize>>(
      initialValue: product.tamanhos,
      validator: (sizes) {
        if (sizes == null || sizes.isEmpty) {
          return "Insira o tamanho do prodtuto";
        } else {
          return null;
        }
      },
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
                      state.value?.add(ItemSize());
                      state.didChange(state.value);
                    })
              ],
            ),
            Column(
              children: state.value!.map((size) {
                return EditItemSize(
                  size: size,
                  key: ObjectKey(size),
                  onRemove: () {
                    state.value?.remove(size);
                    state.didChange(state.value);
                  },
                  onMoveDown: size != state.value?.last
                      ? () {
                          final index = state.value?.indexOf(size);
                          state.value?.remove(size);
                          state.value?.insert(index! + 1, size);
                        }
                      : null,
                  onMoveUp: size != state.value?.first
                      ? () {
                          final index = state.value?.indexOf(size);
                          state.value?.remove(size);
                          state.value?.insert(index! - 1, size);
                        }
                      : null,
                );
              }).toList(),
            ),
            if (state.hasError)
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  state.errorText!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              )
          ],
        );
      },
    );
  }
}
