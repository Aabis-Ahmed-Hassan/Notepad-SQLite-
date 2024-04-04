import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite/modal_class.dart';

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

  Future<int> insertData(ModalClass modalClass) async {
    Database db = await database;

    return await db.insert(
      '$myTable',
      modalClass.toMap(),
    );
  }

  Future<List<ModalClass>> readData() async {
    Database _db = await database;

    List myList = await _db.query('$myTable');
    return myList.map((map) {
      return ModalClass.fromMap(map);
    }).toList();
  }

  Future<int> updateData(ModalClass modalClass) async {
    Database db = await database;
    return await db.update(
      '$myTable',
      modalClass.toMap(),
      where: 'id = ?',
      whereArgs: [modalClass.id],
    );
  }

  Future<int> deleteData(int id) async {
    Database db = await database;

    return await db.delete(myTable, where: 'id = ?', whereArgs: [id]);
  }
}
