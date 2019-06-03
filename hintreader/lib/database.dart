import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hintreader/BookModel.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE Book ("
              "title TEXT,"
              "author TEXT,"
              "picture TEXT,"
              ")");
        });
  }

  newBook(Book newBook) async {
    final db = await database;
    var res = await db.insert("Book", newBook.toMap());
    return res;
  }

  updateBook(Book newBook) async {
    final db = await database;
    var res = await db.update("Book", newBook.toMap(),
        where: "title = ?", whereArgs: [newBook.title]);
    return res;
  }

  getBook(String title) async {
    final db = await database;
    var res = await db.query("Book", where: "title = ?", whereArgs: [title]);
    return res.isNotEmpty ? Book.fromMap(res.first) : null;
  }

  ///USEFUL IF WE WANT TO ADD THE FEATURE OPENED, IN THIS WAY WE HAVE A LIST OF THE LAST BOOKS OPENED
  /*Future<List<Book>> getOpenedBooks() async {
    final db = await database;

    print("works");
    // var res = await db.rawQuery("SELECT * FROM Book WHERE opened=1");
    var res = await db.query("Client", where: "blocked = ? ", whereArgs: [1]);

    List<Client> list =
    res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
    return list;
  }*/

  Future<List<Book>> getAllBooks() async {
    final db = await database;
    var res = await db.query("Book");
    List<Book> list =
    res.isNotEmpty ? res.map((c) => Book.fromMap(c)).toList() : [];
    return list;
  }

  deleteBook(String title) async {
    final db = await database;
    return db.delete("Book", where: "title = ?", whereArgs: [title]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Book");
  }
}
