import 'package:flutter/material.dart';
import 'package:my_series_list/domain/tag.dart';

class InputChipTag extends StatelessWidget {
  final Tag tag;
  final bool selected;
  final void Function(bool)? onSelected;

  const InputChipTag({
    super.key,
    required this.tag,
    required this.selected,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InputChip(
      selected: selected,
      selectedColor: Color(int.parse(tag.colorARGB)),
      label: Text(tag.name),
      shape: const StadiumBorder(),
      onSelected: onSelected,
      side: BorderSide(
        color: Color(
          int.parse(tag.colorARGB),
        ),
      ),
    );
  }
}
