import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String labelText;
  final String? value;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  const InputText({
    super.key,
    required this.labelText,
    this.value,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        keyboardType: keyboardType,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(
              color: Colors.white,
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )),
        initialValue: value,
        onChanged: onChanged,
      ),
    );
  }
}
