import 'dart:async';
import 'dart:io';
import 'package:did_ye_like_it/models/item.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _instance = new DBHelper.internal();

  factory DBHelper() => _instance;

  final String tableItems = "items";
  final String columnId = "id";
  final String columnEatery = "eatery";
  final String columnSupplier = "supplier";
  final String columnDescription = "description";
  final String columnRating = "rating";

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DBHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "didyelikeit.db");

    var db = await openDatabase(path, version: 4, onCreate: _onCreate);

    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $tableItems("
        "$columnId INTEGER PRIMARY KEY, "
        "$columnEatery TEXT, "
        "$columnSupplier TEXT, "
        "$columnDescription TEXT, "
        "$columnRating INTEGER)");
  }

  Future<int> save(Item item) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tableItems", item.toMap());
    return res;
  }

  Future<List> getAll() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableItems ORDER BY $columnId ASC");
    return result;
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $tableItems"));
  }

  Future<Item> getById(int id) async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery("SELECT * FROM $tableItems WHERE $columnId = $id");
    if (result.length == 0) return null;
    return new Item.fromMap(result.first);
  }

  Future<int> delete(id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableItems, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> update(Item item) async {
    var dbClient = await db;
    return await dbClient.update(tableItems, item.toMap(),
        where: "$columnId = ?", whereArgs: [item.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
