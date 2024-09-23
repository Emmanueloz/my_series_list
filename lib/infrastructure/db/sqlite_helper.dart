import 'package:my_series_list/domain/db_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class SQLiteHelper extends DBHelper<Database> {
  static final SQLiteHelper _instance = SQLiteHelper._internal();
  factory SQLiteHelper() => _instance;

  static Database? _database;

  SQLiteHelper._internal();

  @override
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String dbPath = path.join(await getDatabasesPath(), 'series.db');

    if (_database != null) return _database!;
    _database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: _onCreate,
    );
    return _database!;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS series (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        url TEXT NOT NULL,
        tags TEXT NOT NULL
      )""");

    await db.execute("""
      CREATE TABLE IF NOT EXISTS tags (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        colorARGB TEXT NOT NULL
      )""");
  }
}
