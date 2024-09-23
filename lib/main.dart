import 'package:flutter/material.dart';
import 'package:my_series_list/application/series_provider.dart';
import 'package:my_series_list/application/tags_provider.dart';
import 'package:my_series_list/domain/series_repository.dart';
import 'package:my_series_list/infrastructure/db/sqlite_helper.dart';
import 'package:my_series_list/infrastructure/services/tags_sqlite.dart';
import 'package:my_series_list/views/pages/home.dart';
import 'package:my_series_list/views/pages/series_details.dart';
import 'package:my_series_list/views/pages/tags_details.dart';
import 'package:provider/provider.dart';

void main() {
  final SQLiteHelper sqliteHelper = SQLiteHelper();

  final TagsSQLite tagsRepository = TagsSQLite(sqliteHelper);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => SeriesProvider(
          repository: MemorySeriesRepository(),
        ),
      ),
      ChangeNotifierProvider(
        create: (_) => TagsProvider(
          repository: tagsRepository,
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
      // Dark theme

      theme: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.dark(
          primary: Colors.white,
          secondary: Colors.grey,
          surfaceContainer: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/series": (context) => const SeriesDetailsPage(),
        "/tags": (context) => const TagsDetailsPage(),
      },
    );
  }
}
