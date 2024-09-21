import 'package:flutter/material.dart';
import 'package:my_series_list/domain/series.dart';
import 'package:my_series_list/views/components/chip_tags.dart';
import 'package:my_series_list/views/sections/modal_form_series.dart';

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

    Widget showInfo(Series series) {
      String description = series.description!.isEmpty
          ? "Not found description"
          : series.description!;
      String url = series.url!.isEmpty ? "No found URL" : series.url!;

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              series.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(url),
            Wrap(
              spacing: 5,
              children: series.tags.map((tag) => ChipTag(tag: tag)).toList(),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: arguments["series"] == null
          ? showError("Series not found")
          : showInfo(arguments["series"]!),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            scrollControlDisabledMaxHeightRatio: 0.9,
            builder: (context) {
              return ModalFormSeries(
                serie: arguments["series"],
              );
            },
          );
        },
      ),
    );
  }
}
