import 'package:flutter/material.dart';
import 'package:my_series_list/application/series_provider.dart';
import 'package:my_series_list/domain/series.dart';
import 'package:my_series_list/views/components/chip_tags.dart';
import 'package:my_series_list/views/pages/layout.dart';
import 'package:my_series_list/views/sections/modal_form_series.dart';
import 'package:provider/provider.dart';

class SeriesDetailsPage extends StatelessWidget {
  const SeriesDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, Series> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, Series>;

    Widget showError(String error) {
      return Center(
        child: Text(error),
      );
    }

    Widget showInfo(Series serie) {
      String description = serie.description!.isEmpty
          ? "Not found description"
          : serie.description!;

      String url = serie.url!.isEmpty ? "No found URL" : serie.url!;

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              serie.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(url),
            Wrap(
              spacing: 5,
              children: serie.tags.map((tag) => ChipTag(tag: tag)).toList(),
            ),
          ],
        ),
      );
    }

    return Consumer<SeriesProvider>(
      builder: (context, seriesProvider, child) {
        Series? argumentsSeries = arguments["series"];
        Series serie = seriesProvider.listSeries
            .firstWhere((element) => element.id == argumentsSeries!.id);

        return LayoutPage(
          appBar: AppBar(
            title: const Text("Details"),
          ),
          body: argumentsSeries == null
              ? showError("Series not found")
              : showInfo(serie),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.edit),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                scrollControlDisabledMaxHeightRatio: 0.9,
                builder: (context) {
                  return ModalFormSeries(
                    serie: serie,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
