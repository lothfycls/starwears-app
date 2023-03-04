import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/user.dart';

class SharedPreferencesService {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "test.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE IF NOT EXISTS User(id INTEGER PRIMARY KEY,phone TEXT,email TEXT,firstName TEXT,lastName TEXT,address TEXT,username TEXT)");
    debugPrint("Created tables");
  }
 Future removeUser() async {
    var dbClient = await db;
    await dbClient!.transaction((txn) async {
      await txn.rawDelete('DELETE FROM User');
    });
  }
  //Future addWatchList() async {}
  //Future removeWatchList() async {}
  void upDateSharedPreferences(
      String email,
      int id,
      String firstName,
      String lastName,
      String homeAddress,
      String phoneNumber,
      String username) async {
    var dbClient = await db;
    await dbClient!.transaction((txn) async {
      List ids = await txn.rawQuery('SELECT * FROM User WHERE id=$id');

      if (ids.isEmpty) {
        await txn.rawInsert(
            "INSERT INTO User(id,phone,email,firstName,lastName,address,username) VALUES($id,'$phoneNumber','$email','$firstName','$lastName','$homeAddress','$username')");
      }
    });
  }

  void updateInfos(int id, String firstName, String lastName,
      String homeAddress, String phoneNumber, String username) async {
    var dbClient = await db;
    await dbClient!.transaction((txn) async {
      await txn.rawUpdate(
          'UPDATE User SET firstName = ?, lastName = ? , phone = ? , address = ?, username = ? WHERE id = ?',
          [firstName, lastName, homeAddress, phoneNumber, username, id]);
    });
  }

  Future getUser() async {
    var dbClient = await db;
    List<Map> list =
        await dbClient!.rawQuery('SELECT * FROM User ORDER BY id DESC');
    return list.isNotEmpty
        ? User(
            id: list[0]['id'],
            phone: list[0]['phone'],
            email: list[0]['email'],
            firstName: list[0]['firstName'],
            lastName: list[0]['lastName'],
            address: list[0]['address'],
            username: list[0]['username'],
          )
        : null;
  }
}
