import 'package:flutter/material.dart';
import 'package:my_series_list/application/series_provider.dart';
import 'package:my_series_list/application/tags_provider.dart';
import 'package:my_series_list/domain/series_repository.dart';
import 'package:my_series_list/domain/tag_repository.dart';
import 'package:my_series_list/views/pages/home.dart';
import 'package:my_series_list/views/pages/series_details.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => SeriesProvider(
          repository: MemorySeriesRepository(),
        ),
      ),
      ChangeNotifierProvider(
        create: (_) => TagsProvider(
          repository: MemoryTagRepository(),
        ),
      )
    ],
    builder: (context, child) {
      Provider.of<TagsProvider>(context, listen: false).init();
      Provider.of<SeriesProvider>(context, listen: false).init();
      return const MyApp();
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My series',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/series": (context) => const SeriesDetailsPage(),
      },
    );
  }
}
