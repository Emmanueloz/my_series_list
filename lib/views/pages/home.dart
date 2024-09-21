import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_series_list/application/series_provider.dart';
import 'package:my_series_list/application/tags_provider.dart';
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
  late final TagsProvider _tagsProvider;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _seriesProvider = Provider.of<SeriesProvider>(context, listen: false);
    _tagsProvider = Provider.of<TagsProvider>(context, listen: false);
    _seriesProvider.getSeries();
    _tagsProvider.getTags();
  }

  void _onBottomNavigationTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _changeIndex(int index) {
    return index == 0 ? _seriesPage() : _tagsPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'My series' : "My tags"),
      ),
      body: _changeIndex(_selectedIndex),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_outlined),
            activeIcon: Icon(Icons.movie),
            label: "Series",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            activeIcon: Icon(Icons.category),
            label: "Tags",
          ),
        ],
        onTap: _onBottomNavigationTap,
      ),
    );
  }

  Consumer<TagsProvider> _tagsPage() {
    return Consumer<TagsProvider>(builder: (context, tagsProvider, child) {
      if (tagsProvider.listTags.isEmpty) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("No tags found"),
              SizedBox(height: 10),
              Text("Add a new tag"),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: tagsProvider.listTags.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              tagsProvider.listTags[index].name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      );
    });
  }

  Consumer<SeriesProvider> _seriesPage() {
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
