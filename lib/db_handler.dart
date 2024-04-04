import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHandler {
  Database? _database;
  String myTable = 'MYTABLE';
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    Directory _directory = await getApplicationDocumentsDirectory();
    String path = await join(_directory.path, 'mydatabase.db');

    _database = await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''
      CREATE TABLE $myTable (
      id INTEGER PRIMARY KEY,
      name TEXT,
      age INTEGER
      )      
        ''');
    });

    return _database!;
  }

  insertData(int id, String name, int age) async {
    Database db = await database;

    Map<String, dynamic> myMap = {
      'id': id,
      'name': name,
      'age': age,
    };
    await db.insert('$myTable', myMap);
  }

  readData() async {
    Database _db = await database;

    List myList = await _db.query('$myTable');
    return myList;
  }

  updateData(Map<String, dynamic> myMap) async {
    Database db = await database;
    await db.update(
      '$myTable',
      myMap,
      where: 'id = ?',
      whereArgs: [myMap['id']],
    );
  }

  deleteData(int id) async {
    Database db = await database;

    await db.delete(myTable, where: 'id = ?', whereArgs: [id]);
  }
}
