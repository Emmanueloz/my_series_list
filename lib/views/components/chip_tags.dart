import 'package:flutter/material.dart';
import 'package:my_series_list/domain/tag.dart';

class ChipTag extends StatelessWidget {
  final Tag tag;
  const ChipTag({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        tag.name,
        style: const TextStyle(
          color: Color.fromRGBO(34, 34, 34, 1),
        ),
      ),
      padding: const EdgeInsets.all(0),
      shape: const StadiumBorder(
        side: BorderSide(color: Colors.transparent),
      ),
      backgroundColor: Color(int.parse(tag.colorARGB)),
    );
  }
}
