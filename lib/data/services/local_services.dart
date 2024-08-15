import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = "CurrencyConverter.db";
  static const _databaseVersion = 1;

  static const table = 'currencies';

  static const columnId = '_id';
  static const columnCode = 'code';
  static const columnName = 'name';
  static const columnFlagUrl = 'flag_url';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnCode TEXT NOT NULL,
        $columnName TEXT NOT NULL,
        $columnFlagUrl TEXT NOT NULL
      )
    ''');
  }

  Future<void> insert(Map<String, dynamic> row) async {
    final db = await database;
    await db.insert(table, row, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    final db = await database;
    return await db.query(table);
  }
}