import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite/modals/modal.dart';

class DBHelper {
  Database? _database;
  String myTable = 'MyNotes';

  Future<Database> get database async {
    Directory _directory = await getApplicationDocumentsDirectory();
    String path = join(_directory.path, 'my_database.db');

    _database = await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''CREATE TABLE $myTable (
        
        id INTEGER PRIMARY KEY,
        title TEXT,
        subtitle TEXT
        
        )''');
    });

    return _database!;
  }

  Future<int> insertData(ModalClass modalClass) async {
    Database _db = await database;
    return await _db.insert(
      myTable,
      modalClass.toMap(),
    );
  }

  Future<List<ModalClass>> readData() async {
    Database _db = await database;

    List myNotes = await _db.query(myTable);

    return myNotes.map((map) => ModalClass.fromMap(map)).toList();
  }

  Future<int> updateData(ModalClass modalClass) async {
    Database _db = await database;

    return await _db.update(myTable, modalClass.toMap(),
        whereArgs: [modalClass.id], where: 'id = ?');
  }

  Future<int> deleteData(int id) async {
    Database _db = await database;

    return await _db.delete(myTable, where: 'id = ?', whereArgs: [id]);
  }
}
