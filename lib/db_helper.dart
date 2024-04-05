import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

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

  Future<int> insertData(Map<String, dynamic> myData) async {
    Database _db = await database;
    return await _db.insert(myTable, myData);
  }

  Future<List> readData() async {
    Database _db = await database;

    List myNotes = await _db.query(myTable);
    return myNotes;
  }
}
