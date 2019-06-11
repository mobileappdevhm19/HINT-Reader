import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
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
              "id INTEGER PRIMARY KEY,"
              "title TEXT,"
              "author TEXT,"
              "picture TEXT"
              //"opened BIT,"
              ")");
        });
  }

  //show a progress indicator, fetch data, close indicator and return
  Future<void> loadBookFromJson(BuildContext context) async {
    //fetch data from local database
    var bookList = await getAllBooks();// = await getAllBooks();
    if(bookList.length == 0) {
      String data = await DefaultAssetBundle.of(context).loadString(
          "assets/books.json");
      var books = bookFactoryFromJson(data).books;
      //foreach book (we have got from the api) insert into local database
      books.forEach((book) => newBook(book));
      bookList = books;
    }
    //return bookList; //return the fetched contacts
  }

  newBook(Book newBook) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Book");
    int id = table.first["id"];
    if(newBook.id != null || newBook.id != 0)
      id = newBook.id;
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Book (id,title,author,picture)"
            " VALUES (?,?,?,?)",
        [id, newBook.title, newBook.author, newBook.picture]);
    return raw;
  }

  /*newBook(Book newBook) async {
    final db = await database;
    var res = await db.insert("Book", newBook.toMap());
    return res;
  }*/

  //update local database
  Future<void> updateBooks(BuildContext context) async {


    //get the data from the json)
    String data = await DefaultAssetBundle.of(context).loadString(
        "assets/books.json");
    //create a list of all the books in the json
    var books = bookFactoryFromJson(data).books;
    //foreach contact call update or create
    books.forEach((book) => updateOrCreate(book));
  }

  //update contact if available or create it
  Future<void> updateOrCreate(Book book) async {
    //try to update contact
    var result = await updateBook(book);
    if (result == 0) {
      //update will return 1 for true, 0 for false
      await newBook(book); //insert if update failed
    }
  }

  updateBook(Book newBook) async {
    final db = await database;
    var res = await db.update("Book", newBook.toMap(),
        where: "id = ?", whereArgs: [newBook.id]);
    return res;
  }

  //get a book given the title
  getBook(String title) async {
    final db = await database;
    var res = await db.query("Book", where: "title = ?", whereArgs: [title]);
    return res.isNotEmpty ? Book.fromMap(res.first) : null;
  }

  ///USEFUL IF WE WANT TO ADD THE FEATURE OPENED, IN THIS WAY WE HAVE A LIST OF THE LAST BOOKS OPENED
  Future<List<Book>> getOpenedBooks() async {
    final db = await database;

    //print("works");
    // var res = await db.rawQuery("SELECT * FROM Book WHERE opened=1");
    var res = await db.query("Client", where: "opened = ? ", whereArgs: [1]);

    List<Book> list =
    res.isNotEmpty ? res.map((c) => Book.fromMap(c)).toList() : [];
    return list;
  }

  //get all the books in the database
  Future<List<Book>> getAllBooks() async {
    final db = await database;
    var res = await db.query("Book");
    List<Book> list =
    res.isNotEmpty ? res.map((c) => Book.fromMap(c)).toList() : [];
    return list;
  }

  //delete a book given the title
  deleteBook(String title) async {
    final db = await database;
    return db.delete("Book", where: "title = ?", whereArgs: [title]);
  }

  //delete all the book
  deleteAll() async {
    final db = await database;
    List<Book> books = await getAllBooks();
    books.forEach((book) => db.delete("Book", where: "title = ?", whereArgs: [book.title]));
  }
}
