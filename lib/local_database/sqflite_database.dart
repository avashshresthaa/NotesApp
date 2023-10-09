import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'database_models/calander_model/calander_model.dart';

class DatabaseHelper {
  static DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;
  DatabaseHelper._init();
  static const int _databaseVersion = 1;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("policeS.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, filePath);
    return openDatabase(path,
        onUpgrade: _upgradeDB, version: _databaseVersion, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(NotessModelDatabase.tableCreation);
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion == 1 && newVersion == 2) {
      // Execute SQL statement to create the new table
      // await db.execute(LocationModelDatabase.tableCreation);
    }
    // Add more upgrade steps if needed for future versions
  }
}
