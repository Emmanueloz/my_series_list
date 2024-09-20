import 'package:flutter/material.dart';
import 'package:my_series_list/application/series_provider.dart';
import 'package:my_series_list/views/components/card_serie.dart';
import 'package:my_series_list/views/sections/modal_form_series.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final SeriesProvider _seriesProvider;

  @override
  void initState() {
    super.initState();
    _seriesProvider = Provider.of<SeriesProvider>(context, listen: false);
    _seriesProvider.getSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My series'),
      ),
      body: Consumer<SeriesProvider>(builder: (context, seriesProvider, child) {
        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: seriesProvider.listSeries.length,
          itemBuilder: (context, index) {
            return CardSerie(
              series: seriesProvider.listSeries[index],
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            scrollControlDisabledMaxHeightRatio: 0.9,
            builder: (context) {
              return const ModalFormSeries();
            },
          );
        },
      ),
    );
  }
}
