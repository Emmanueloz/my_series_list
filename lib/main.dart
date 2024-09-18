import 'package:flutter/material.dart';
import 'package:my_series_list/application/series.dart';
import 'package:my_series_list/models/series_repository.dart';
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
      )
    ],
    builder: (context, child) {
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
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/series": (context) => const SeriesDetailsPage(),
      },
    );
  }
}
