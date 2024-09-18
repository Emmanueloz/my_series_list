import 'package:my_series_list/models/series.dart';
import 'package:my_series_list/models/series_repository.dart';

class SeriesSQLite extends ISeriesRepository {
  @override
  Future<void> init() async {}

  @override
  Future<List<Series>> getSeries() async {
    return [];
  }

  @override
  Future<List<Series>> getSeriesByTag(String tag) async {
    return [];
  }

  @override
  Future<List<Series>> getSeriesByName(String name) async {
    return [];
  }

  @override
  Future<void> addSeries(Series series) async {}

  @override
  Future<void> deleteSeries(Series series) async {}

  @override
  Future<void> updateSeries(Series series) async {}
}
