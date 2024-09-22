import 'package:flutter/material.dart';
import 'package:my_series_list/domain/tag.dart';

class CardTag extends StatelessWidget {
  final Tag tag;
  const CardTag({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(int.parse(tag.colorARGB)),
        ),
        title: Text(
          tag.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            "/tags",
            arguments: {
              "tag": tag,
            },
          );
        },
      ),
    );
  }
}
