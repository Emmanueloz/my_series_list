import 'package:my_series_list/domain/query_series.dart';
import 'package:my_series_list/domain/series.dart';
import 'package:my_series_list/domain/series_repository.dart';
import 'package:my_series_list/domain/tag.dart';
import 'package:my_series_list/infrastructure/db/sqlite_helper.dart';
import 'package:sqflite/sqflite.dart';

class SeriesSQLite extends ISeriesRepository {
  final SQLiteHelper _sqliteHelper;

  SeriesSQLite(this._sqliteHelper);

  @override
  Future<void> init() async {}

  @override
  Future<List<Series>> getSeries() async {
    final db = await _sqliteHelper.database;

    // Consulta para obtener las series junto con sus tags
    final List<Map<String, dynamic>> seriesResult = await db.rawQuery("""
      SELECT 
        series.id AS series_id, 
        series.name AS series_name, 
        series.description AS series_description, 
        series.url AS series_url, 
        tags.id AS tag_id, 
        tags.name AS tag_name, 
        tags.colorARGB AS tag_color
      FROM series
      LEFT JOIN series_tags ON series.id = series_tags.series_id
      LEFT JOIN tags ON tags.id = series_tags.tag_id
      ORDER BY series.id DESC
    """);

    // Crear un mapa para agrupar las series con sus tags
    final Map<int, Series> seriesMap = {};

    for (var row in seriesResult) {
      final int seriesId = row['series_id'];
      final series = seriesMap.putIfAbsent(seriesId, () {
        return Series(
          id: seriesId,
          name: row['series_name'],
          description: row['series_description'],
          url: row['series_url'],
          tags: [],
        );
      });

      if (row['tag_id'] != null) {
        series.tags.add(Tag(
          id: row['tag_id'],
          name: row['tag_name'],
          colorARGB: row['tag_color'],
        ));
      }
    }

    return seriesMap.values.toList();
  }

  @override
  Future<void> addSeries(Series series) async {
    final db = await _sqliteHelper.database;
    final batch = db.batch();

    // Insertar la serie en la tabla 'series'
    final seriesId = await db.insert(
      'series',
      {
        'name': series.name,
        'description': series.description,
        'url': series.url,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Insertar la relación en 'series_tags' usando los IDs de los tags existentes
    for (var tag in series.tags) {
      await db.insert(
        'series_tags',
        {
          'series_id': seriesId,
          'tag_id': tag.id, // Usar el ID del tag ya existente
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }

    await batch.commit();
  }

  @override
  Future<void> deleteSeries(Series series) async {
    final db = await _sqliteHelper.database;
    final batch = db.batch();

    // Eliminar la serie
    await db.delete(
      'series',
      where: 'id = ?',
      whereArgs: [series.id],
    );

    // Eliminar todas las relaciones de la serie
    await db.delete(
      'series_tags',
      where: 'series_id = ?',
      whereArgs: [series.id],
    );

    await batch.commit();
  }

  @override
  Future<void> updateSeries(Series series) async {
    final db = await _sqliteHelper.database;
    final batch = db.batch();
    await db.update(
      'series',
      {
        'name': series.name,
        'description': series.description,
        'url': series.url,
      },
      where: 'id = ?',
      whereArgs: [series.id],
    );

    // Eliminar todas las relaciones de la serie
    await db.delete(
      'series_tags',
      where: 'series_id = ?',
      whereArgs: [series.id],
    );

    // Insertar las nuevas relaciones
    for (var tag in series.tags) {
      await db.insert(
        'series_tags',
        {
          'series_id': series.id,
          'tag_id': tag.id,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
    await batch.commit();
  }

  @override
  Future<List<Series>> query(QuerySeries query) {
    // TODO: implement query
    throw UnimplementedError();
  }
}
