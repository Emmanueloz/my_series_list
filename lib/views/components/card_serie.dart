import 'package:flutter/material.dart';
import 'package:my_series_list/domain/series.dart';
import 'package:my_series_list/views/components/chip_tags.dart';

class CardSerie extends StatelessWidget {
  final Series series;
  const CardSerie({
    super.key,
    required this.series,
  });

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      color: const Color.fromRGBO(33, 150, 243, 1),
      child: ListTile(
        title: Text(
          series.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Wrap(
          spacing: 5,
          children: series.tags
              .sublist(
                0,
                series.tags.length > 5 ? 5 : series.tags.length,
              )
              .map((tag) => ChipTag(tag: tag))
              .toList(),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            "/series",
            arguments: {
              "series": series,
            },
          );
        },
      ),
    );
  }
}
