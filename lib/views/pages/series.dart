import 'package:flutter/material.dart';
import 'package:my_series_list/application/series_provider.dart';
import 'package:my_series_list/views/components/card_serie.dart';
import 'package:provider/provider.dart';

class SeriesPage extends StatefulWidget {
  const SeriesPage({super.key});

  @override
  State<SeriesPage> createState() => _SeriesPageState();
}

class _SeriesPageState extends State<SeriesPage> {
  late final SeriesProvider _seriesProvider;

  @override
  void initState() {
    super.initState();
    _seriesProvider = Provider.of<SeriesProvider>(context, listen: false);
    _seriesProvider.getSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SeriesProvider>(builder: (context, seriesProvider, child) {
      if (seriesProvider.listSeries.isEmpty) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("No series found"),
              SizedBox(height: 10),
              Text("Add a new series"),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: seriesProvider.listSeries.length,
        itemBuilder: (context, index) {
          return CardSerie(
            series: seriesProvider.listSeries[index],
            onDelete: (series) {
              seriesProvider.deleteSeries(series);
            },
          );
        },
      );
    });
  }
}
