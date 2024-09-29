import 'package:flutter/material.dart';
import 'package:my_series_list/views/pages/search_series.dart';
import 'package:my_series_list/views/pages/series.dart';
import 'package:my_series_list/views/pages/tags.dart';
import 'package:my_series_list/views/provider/navigator.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final navigator = Provider.of<NavigatorProvider>(context);

    Widget page;
    switch (navigator.index) {
      case 0:
        page = const SeriesPage();
        break;
      case 1:
        page = const SearchSeries();
        break;
      case 2:
        page = const TagsPage();
        break;
      default:
        page = const SeriesPage();
    }

    return page;
  }
}
