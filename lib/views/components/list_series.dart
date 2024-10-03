import 'package:flutter/material.dart';
import 'package:my_series_list/domain/series.dart';
import 'package:my_series_list/views/components/card_serie.dart';

class ListSeries extends StatelessWidget {
  final List<Series> listSeries;
  final void Function(Series)? onDelete;
  const ListSeries({
    super.key,
    required this.listSeries,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: listSeries.length,
      itemBuilder: (context, index) {
        return CardSerie(
          series: listSeries[index],
          onDelete: onDelete,
        );
      },
    );
  }
}
