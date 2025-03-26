import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardTextField extends StatelessWidget {
  final String title;
  final bool bold;
  final String hint;
  final TextInputType textInputType;
  final List<TextInputFormatter> inputFormatters;
  final FormFieldValidator<String> validator;
  final int maxLength;
  final TextAlign textAlign;
  final FocusNode focusNode;
  final Function(String) onSubmitted;

  const CardTextField(
      {super.key,
      required this.title,
      required this.bold,
      required this.hint,
      required this.textInputType,
      required this.inputFormatters,
        required this.validator,
        required this.maxLength,
         this.textAlign = TextAlign.start, required this.focusNode, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: "",
      validator: validator,
      builder: (state){

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.white, fontSize: 10),
                  ),
                  if(state.hasError)
                    const Text(
                      "Inválido",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 9
                      ),
                    ),
                ],
              ),
              TextFormField(
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: bold ? FontWeight.bold : FontWeight.w500),
                decoration: InputDecoration(
                    hintText: hint,
                    helperStyle: TextStyle(
                      color: Colors.white.withAlpha(100),
                    ),
                    counterText: "",
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 2)),
                keyboardType: textInputType,
                inputFormatters: inputFormatters,
                cursorColor: Colors.white,
                onChanged: (text){
                  state.didChange(text);
                },
                focusNode: focusNode,
                onFieldSubmitted: onSubmitted,
              )
            ],
          ),
        );
      },
    );
  }
}
