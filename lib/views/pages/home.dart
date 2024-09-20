import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_series_list/application/series_provider.dart';
import 'package:my_series_list/views/components/card_serie.dart';
import 'package:my_series_list/views/components/input_text.dart';
import 'package:my_series_list/views/components/select_tag.dart';
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
              return Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "New serie",
                      style: TextStyle(fontSize: 20),
                    ),
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          InputText(
                            labelText: "Name",
                            onChanged: (value) {},
                          ),
                          InputText(
                            labelText: "Description",
                            keyboardType: TextInputType.multiline,
                            onChanged: (value) {},
                          ),
                          InputText(
                            labelText: "URL",
                            keyboardType: TextInputType.url,
                            onChanged: (value) {},
                          ),
                          SelectTag(
                            labelText: "Tags",
                            onChanged: (value) {},
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            child: const Text("Save",
                                style: TextStyle(color: Colors.black)),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
