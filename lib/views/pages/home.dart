import 'package:flutter/material.dart';
import 'package:my_series_list/application/series.dart';
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
          itemCount: seriesProvider.listSeries.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(seriesProvider.listSeries[index].name),
              subtitle: Wrap(
                spacing: 5,
                children: seriesProvider.listSeries[index].tags
                    .sublist(
                      0,
                      seriesProvider.listSeries[index].tags.length > 5
                          ? 5
                          : seriesProvider.listSeries[index].tags.length,
                    )
                    .map(
                      (tag) => Chip(
                        label: Text(tag),
                        padding: const EdgeInsets.all(0),
                      ),
                    )
                    .toList(),
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  "/series",
                  arguments: {
                    "series": seriesProvider.listSeries[index],
                  },
                );
              },
            );
          },
        );
      }),
    );
  }
}
