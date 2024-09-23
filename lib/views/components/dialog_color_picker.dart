import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class DialogColorPicker extends StatelessWidget {
  final String colorARGB;
  final void Function(Color color) onColorChanged;

  const DialogColorPicker({
    super.key,
    required this.colorARGB,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Color"),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: Color(
                    int.parse(colorARGB),
                  ),
                  onColorChanged: onColorChanged,
                ),
              ),
            );
          },
        )
      },
      style: TextButton.styleFrom(
        backgroundColor: Color(
          int.parse(colorARGB),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        "Color picker",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
