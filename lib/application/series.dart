import 'package:flutter/material.dart';
import 'package:my_series_list/models/series.dart';
import 'package:my_series_list/models/series_repository.dart';

class SeriesProvider with ChangeNotifier {
  final ISeriesRepository _repository;

  List<Series> listSeries = [];

  SeriesProvider({required ISeriesRepository repository})
      : _repository = repository;

  Future<void> init() async {
    await _repository.init();
  }

  Future<void> getSeries() async {
    listSeries = await _repository.getSeries();
    notifyListeners();
  }

  Future<void> getSeriesByTag(String tag) async {
    listSeries = await _repository.getSeriesByTag(tag);
    notifyListeners();
  }

  Future<void> getSeriesByName(String name) async {
    listSeries = await _repository.getSeriesByName(name);
    notifyListeners();
  }

  Future<void> addSeries(Series series) async {
    await _repository.addSeries(series);
    listSeries = await _repository.getSeries();
    notifyListeners();
  }

  Future<void> deleteSeries(Series series) async {
    await _repository.deleteSeries(series);
    listSeries = await _repository.getSeries();
    notifyListeners();
  }

  Future<void> updateSeries(Series series) async {
    await _repository.updateSeries(series);
    listSeries = await _repository.getSeries();
    notifyListeners();
  }
}
