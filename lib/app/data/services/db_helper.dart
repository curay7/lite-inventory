import 'package:first/app/data/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "product";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }

    try {
      String _path = await getDatabasesPath() + 'products.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          print("Creating A New One");
          return db.execute(
            "CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "title TEXT, note TEXT, date String,"
            "startTime STRING,endTime String,"
            "skl INTEGER, "
            "qty INTEGER, "
            "remind INTEGER, "
            "color INTEGER, "
            "isCompleted INTEGER)",
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Product? product) async {
    print("Insert Db");
    return await _db?.insert(_tableName, product!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_tableName);
  }

  static delete(Product product) async {
    return await _db!
        .delete(_tableName, where: 'id=?', whereArgs: [product.id]);
  }

  static update({required int id, required Product product}) async {
    print("DATABASE");
    print(id);
    return await _db!.rawUpdate('''
              UPDATE product
              SET isCompleted = ?, title = ? , skl = ? , qty = ?
              WHERE id =?
            ''', [1, product.title, product.skl, product.qty, id]);
  }
}
