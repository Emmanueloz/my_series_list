import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class SQLiteHelper {
  static final SQLiteHelper _instance = SQLiteHelper._internal();
  factory SQLiteHelper() => _instance;

  static Database? _database;

  SQLiteHelper._internal();

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
      version: 2, // Cambiar la versión a 2 para ejecutar el `onUpgrade`
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    return _database!;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS series (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT,
        url TEXT
      )""");

    await db.execute("""
      CREATE TABLE IF NOT EXISTS tags (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        colorARGB TEXT NOT NULL
      )""");

    await db.execute("""
      CREATE TABLE IF NOT EXISTS series_tags (
        series_id INTEGER NOT NULL,
        tag_id INTEGER NOT NULL,
        FOREIGN KEY (series_id) REFERENCES series (id) ON DELETE CASCADE,
        FOREIGN KEY (tag_id) REFERENCES tags (id) ON DELETE CASCADE,
        PRIMARY KEY (series_id, tag_id)
      )""");
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Realizar los cambios necesarios para la versión 2
      await db.execute("ALTER TABLE series DROP COLUMN tags");

      // Crear tabla intermedia para la relación N:N entre series y tags
      await db.execute("""
        CREATE TABLE IF NOT EXISTS series_tags (
          series_id INTEGER NOT NULL,
          tag_id INTEGER NOT NULL,
          FOREIGN KEY (series_id) REFERENCES series (id) ON DELETE CASCADE,
          FOREIGN KEY (tag_id) REFERENCES tags (id) ON DELETE CASCADE,
          PRIMARY KEY (series_id, tag_id)
        )""");
    }
  }
}
