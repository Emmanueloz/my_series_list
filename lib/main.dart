import 'package:flutter/material.dart';
import 'package:my_series_list/application/series_provider.dart';
import 'package:my_series_list/application/tags_provider.dart';
import 'package:my_series_list/infrastructure/db/sqlite_helper.dart';
import 'package:my_series_list/infrastructure/services/series_sqlite.dart';
import 'package:my_series_list/infrastructure/services/tags_sqlite.dart';
import 'package:my_series_list/views/pages/home.dart';
import 'package:my_series_list/views/pages/series_details.dart';
import 'package:my_series_list/views/pages/tags_details.dart';
import 'package:my_series_list/views/provider/navigator.dart';
import 'package:provider/provider.dart';

void main() {
  final SQLiteHelper sqliteHelper = SQLiteHelper();

  final TagsSQLite tagsRepository = TagsSQLite(sqliteHelper);
  final SeriesSQLite seriesRepository = SeriesSQLite(sqliteHelper);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => SeriesProvider(
          repository: seriesRepository,
        ),
      ),
      ChangeNotifierProvider(
        create: (_) => TagsProvider(
          repository: tagsRepository,
        ),
      ),
      ChangeNotifierProvider(
        create: (_) => NavigatorProvider(),
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
      ).copyWith(
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        colorScheme: const ColorScheme.dark(
          primary: Colors.black,
          secondary: Colors.white,
        ),
        cardTheme: const CardTheme(
          color: Color.fromARGB(255, 28, 28, 34),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
          selectionColor: Color.fromRGBO(255, 255, 255, 0.2),
          selectionHandleColor: Colors.white,
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
//