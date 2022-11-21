import 'package:first/app/data/model/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "task";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }

    try {
      String _path = await getDatabasesPath() + 'tasks.db';
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

  static Future<int> insert(Task? task) async {
    print("Insert Db");
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_tableName);
  }

  static delete(Task task) async {
    return await _db!.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }

  static update({required int id, required Task task}) async {
    print("DATABASE");
    print(id);
    // print(task.skl);
    // print(task.qty);
    // final data = {'title': task.title, 'skl': 777, 'qty': 777};
    // return await _db!
    //     .update(_tableName, data, where: "id = ?", whereArgs: [task.id]);
    return await _db!.rawUpdate('''
              UPDATE task
              SET isCompleted = ?, title = ? , skl = ? , qty = ?
              WHERE id =?
            ''', [1, task.title, task.skl, task.qty, id]);
  }
}
