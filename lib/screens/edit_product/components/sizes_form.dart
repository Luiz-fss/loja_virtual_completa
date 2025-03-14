import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/common/custom_icon_button.dart';
import 'package:loja_virtual_completa/models/item_size.dart';
import 'package:loja_virtual_completa/models/product.dart';

import 'edit_item_size.dart';

class SizesForm extends StatelessWidget {
  final Product product;
  const SizesForm({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemSize>>(
      initialValue: product.sizes,
      validator: (sizes){
        if(sizes == null || sizes.isEmpty){
          return "Insira um tamanho";
        }
        return null;
      },
      builder: (state){
        return Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Tamanhos",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                CustomIconButton(
                  iconData: Icons.add,
                  color: Colors.black,
                  onTap: (){
                    state.value!.add(ItemSize());
                    state.didChange(state.value);
                  },
                )
              ],
            ),
            Column(
              children: state.value!.map((size){
                return EditItemSize(
                  key: ObjectKey(size),
                  size:size,
                  onRemove: (){
                  state.value?.remove(size);
                  state.didChange(state.value);
                  },
                  onMoveDown: size != state.value!.last ?(){
                    final index = state.value!.indexOf(size);
                    state.value?.remove(size);
                    state.value?.insert(index+1, size);
                    state.didChange(state.value!);
                  }:null,
                  onMoveUp: size != state.value!.first ? (){
                    final index = state.value!.indexOf(size);
                    state.value?.remove(size);
                    state.value?.insert(index-1, size);
                    state.didChange(state.value!);
                  }:null,
                );
              }).toList(),
            ),
            if(state.hasError)
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12
                  ),
                ),
              )
          ],
        );

      },
    );
  }
}
