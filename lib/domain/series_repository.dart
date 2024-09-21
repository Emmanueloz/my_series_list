import 'package:my_series_list/domain/series.dart';
import 'package:my_series_list/domain/tag.dart';

abstract class ISeriesRepository {
  Future<void> init();
  Future<List<Series>> getSeries();
  Future<List<Series>> getSeriesByTag(String tag);
  Future<List<Series>> getSeriesByName(String name);
  Future<void> addSeries(Series series);
  Future<void> deleteSeries(Series series);
  Future<void> updateSeries(Series series);
}

class MemorySeriesRepository implements ISeriesRepository {
  final List<Series> _series = [];

  @override
  Future<void> init() async {
    if (_series.isNotEmpty) return;
    _series.add(Series(
      id: 1,
      name: 'The Walking Dead',
      description:
          'A post-apocalyptic horror series set in the fictional American city of Albany.',
      tags: [
        Tag(name: "horror", colorARGB: "0xfffa5252"),
        Tag(name: "drama", colorARGB: "0xff099268"),
        Tag(name: "thriller", colorARGB: "0xfff08c00"),
      ],
      url: 'https://www.imdb.com/title/tt1520211/',
    ));
    _series.add(Series(
      id: 2,
      name: 'The Walking Dead: World Beyond',
      description:
          'A sequel to The Walking Dead, set in the fictional American city of Albany.',
      tags: [
        Tag(name: "horror", colorARGB: "0xfffa5252"),
        Tag(name: "drama", colorARGB: "0xff099268"),
        Tag(name: "thriller", colorARGB: "0xfff08c00"),
      ],
      url: 'https://www.imdb.com/title/tt1520211/',
    ));
    _series.add(Series(
      id: 1,
      name: 'The Walking Dead: Michonne',
      description:
          'A sequel to The Walking Dead, set in the fictional American city of Albany.',
      tags: [
        Tag(name: "horror", colorARGB: "0xfffa5252"),
        Tag(name: "drama", colorARGB: "0xff099268"),
        Tag(name: "thriller", colorARGB: "0xfff08c00"),
      ],
      url: 'https://www.imdb.com/title/tt1520211/',
    ));
  }

  @override
  Future<List<Series>> getSeries() async {
    return _series;
  }

  @override
  Future<List<Series>> getSeriesByTag(String tag) async {
    return _series.where((series) => series.tags.contains(tag)).toList();
  }

  @override
  Future<List<Series>> getSeriesByName(String name) async {
    return _series.where((series) => series.name == name).toList();
  }

  @override
  Future<void> addSeries(Series series) async {
    series.id = _series.length + 1;
    _series.add(series);
  }

  @override
  Future<void> deleteSeries(Series series) async {
    _series.remove(series);
  }

  @override
  Future<void> updateSeries(Series series) async {
    List<Series> newSeries =
        _series.map((s) => s.id == series.id ? series : s).toList();

    _series.clear();
    _series.addAll(newSeries);
  }
}
