import 'package:flutter/material.dart';
import 'package:my_series_list/domain/series.dart';
import 'package:my_series_list/views/components/chip_tags.dart';

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
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              arguments["series"]!.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              arguments["series"]!.description!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(arguments["series"]!.url!),
            Wrap(
              spacing: 5,
              children: arguments["series"]!
                  .tags
                  .map((tag) => ChipTag(tag: tag))
                  .toList(),
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
    );
  }
}
