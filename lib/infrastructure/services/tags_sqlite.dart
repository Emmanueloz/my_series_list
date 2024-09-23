import 'package:my_series_list/domain/tag.dart';
import 'package:my_series_list/domain/tag_repository.dart';
import 'package:my_series_list/infrastructure/db/sqlite_helper.dart';

class TagsSQLite extends ITagRepository {
  final SQLiteHelper _sqliteHelper;

  TagsSQLite(this._sqliteHelper);

  @override
  Future<void> init() async {}

  @override
  Future<List<Tag>> getTags() async {
    final db = await _sqliteHelper.database;
    final List<Map<String, dynamic>> result = await db.query("tags");
    return result.map((e) => Tag.fromJson(e)).toList();
  }

  @override
  Future<void> addTag(Tag tag) async {
    final db = await _sqliteHelper.database;
    await db.insert("tags", tag.toJson());
  }

  @override
  Future<void> deleteTag(Tag tag) async {
    final db = await _sqliteHelper.database;
    await db.delete("tags", where: "id = ?", whereArgs: [tag.id]);
  }

  @override
  Future<void> updateTag(Tag tag) async {
    final db = await _sqliteHelper.database;
    await db.update("tags", tag.toJson(), where: "id = ?", whereArgs: [tag.id]);
  }
}
