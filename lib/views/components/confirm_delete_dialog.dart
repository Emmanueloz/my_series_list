import 'package:flutter/material.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final String textTitle;
  final String textContent;

  const ConfirmDeleteDialog({
    super.key,
    required this.textTitle,
    required this.textContent,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(textTitle),
      content: Text(textContent),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: const Text("Delete"),
        ),
      ],
    );
  }
}
