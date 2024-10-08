import 'package:flutter/material.dart';
import 'package:my_series_list/application/series_provider.dart';
import 'package:my_series_list/views/components/list_series.dart';
import 'package:my_series_list/views/pages/layout.dart';
import 'package:my_series_list/views/sections/modal_form_series.dart';
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
    return LayoutPage(
      appBar: AppBar(
        title: const Text("My series"),
      ),
      body: Consumer<SeriesProvider>(builder: (context, seriesProvider, child) {
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

        return ListSeries(
          listSeries: seriesProvider.listSeries,
          onDelete: (series) => seriesProvider.deleteSeries(series),
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            scrollControlDisabledMaxHeightRatio: 0.9,
            builder: (context) => const ModalFormSeries(),
          );
        },
      ),
      showNavigationBar: true,
    );
  }
}
