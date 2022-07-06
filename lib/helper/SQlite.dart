import 'dart:async';
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';

class SQlite {
  final String _databaseName = "Name.db";
  final int _databaseVersion = 1;

  final String _createSQL = "CREATE TABLE Name(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)";

  late String createSqlCommand;
  late String databasePath;
  late String dbPath;
  late Database _database;

  void openOrCreateDatabase() async{
    createSqlCommand = _createSQL;
    databasePath = await getDatabasesPath();
    dbPath = join(databasePath, _databaseName);
    _database = await openDatabase(dbPath, version: _databaseVersion, onCreate: createDatabase);
  } //Asynchronous -> not in order

  Future<void> createDatabase(Database db, int version) async {
    if(createSqlCommand != ""){
      await db.execute(createSqlCommand);
    }
  }

  void closeDatabase() async {
    createSqlCommand = _createSQL;
    databasePath = await getDatabasesPath();
    dbPath = join(databasePath, _databaseName);
    _database = await openDatabase(dbPath, version: _databaseVersion, onCreate: createDatabase);

    return _database.close();
  }

  Future<List<Map<String, Object?>>> queryDatabase(String sqlString) async{
    createSqlCommand = _createSQL;
    databasePath = await getDatabasesPath();
    dbPath = join(databasePath, _databaseName);
    _database = await openDatabase(dbPath, version: _databaseVersion, onCreate: createDatabase);

    return await _database.rawQuery(sqlString);
  }

  Future<int> insertDatabase(String sqlString) async {
    createSqlCommand = _createSQL;
    databasePath = await getDatabasesPath();
    dbPath = join(databasePath, _databaseName);
    _database = await openDatabase(dbPath, version: _databaseVersion, onCreate: createDatabase);

    return await _database.rawInsert(sqlString);
  }

  Future<int> updateDatabase(String sqlString) async {
    createSqlCommand = _createSQL;
    databasePath = await getDatabasesPath();
    dbPath = join(databasePath, _databaseName);
    _database = await openDatabase(dbPath, version: _databaseVersion, onCreate: createDatabase);

    return await _database.rawUpdate(sqlString);
  }

  Future<int> deleteDatabase(String sqlString) async {
    createSqlCommand = _createSQL;
    databasePath = await getDatabasesPath();
    dbPath = join(databasePath, _databaseName);
    _database = await openDatabase(dbPath, version: _databaseVersion, onCreate: createDatabase);

    return await _database.rawDelete(sqlString);
  }



}