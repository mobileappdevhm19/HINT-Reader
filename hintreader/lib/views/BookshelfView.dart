import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:hintreader/BookCard.dart';
import 'package:hintreader/BookModel.dart';
import 'package:hintreader/database.dart';
import 'package:hintreader/views/insertBook.dart';
import 'package:hintreader/views/deleteBook.dart';

class Bookshelf extends StatefulWidget {
  Bookshelf(this.title);

  final String title;
  static bool fromBookView = false;

  @override
  _BookshelfState createState() => _BookshelfState();
}

class _BookshelfState extends State<Bookshelf>
    with AfterLayoutMixin<Bookshelf> {
  Size box = Size(200, 200);
  double width = 0;
  double height = 0;
  bool vertical = true;
  List<Book> _books;
  List<Book> _openedBooks;

  @override
  Widget build(BuildContext context) {
    print("CAZZO");
    //this is needed to update the openedBook list
    if(Bookshelf.fromBookView) {
      _getBooks();
      Bookshelf.fromBookView = false;
    }
      return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            FlatButton(
              child: Icon(Icons.delete_sweep, color: Colors.orange),
              onPressed: () => {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 16.0),
                            child: RaisedButton(
                              onPressed: () {
                                DBProvider.db.deleteAll().then((value) =>
                                    _getBooks());
                                Navigator.pop(context);
                              },
                              child: Text('Delete all'),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 16.0),
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return DeleteBook();
                                  }),
                                ).then((value) => _getBooks());
                              },
                              child: Text('Delete a book'),
                            ),
                          ),
                        ],
                      );
                    })
              },
            ),
          ],
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //whole library
            new Expanded(child: bookGrid(_books)),
            Row(children: <Widget>[
              Expanded(child: Divider()),
              Text("MOST RECENT"),
              Expanded(child: Divider()),
            ]),
            //most recent
            new Container(
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                child: recentBookGrid(_openedBooks)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: RaisedButton(
                          onPressed: () {
                            _getBooks(update: true).then((value) => _getBooks());
                            Navigator.pop(context);
                          },
                          child: Text('Read again the json'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return InsertBook();
                              }),
                            ).then((value) => _getBooks());
                          },
                          child: Text('Add a new book'),
                        ),
                      ),
                    ],
                  );
                });
          },
        ),
        //bottomNavigationBar: recentBookGrid(),
      );
  }

  bookGrid(List<Book> books) {
    var xAC = 3;

    return GridView.count(
      crossAxisCount: xAC, //how many books per row
      children: List.generate(books != null ? books.length : 0, (index) {
        return bookGridItem(books[index]);
      }),
    );
  }

  recentBookGrid(List<Book> books) {
    return GridView.count(
      crossAxisCount: 1, //how many books per row
      scrollDirection: Axis.horizontal,
      children: List.generate(books != null ? books.length : 0, (index) {
        return bookGridItem(books[index]);
      }),
    );
  }

  bookGridItem(Book item) {
    return Container(
        constraints: BoxConstraints.loose(box),
        child: BookCard(item.picture, item.title, item.author));
  }

  //use this method to do something after the screen was build the first time
  @override
  void afterFirstLayout(BuildContext context) {
    DBProvider.db.loadBookFromJson(context).then((value) => _getBooks());
  }

  //get all the books
  Future<void> _getBooks({bool update = false, bool rebuild = true}) async {
    List<Book> books = new List<Book>(); //create a empty list
    List<Book> openedBooks = new List<Book>(); //create a empty list
    if (update) {
      //if update is marked
      await DBProvider.db
          .updateBooks(context); //fetch data from the json and update database
    }
    books = await DBProvider.db.getAllBooks(); //load contacts from the database
    openedBooks =
        await DBProvider.db.getOpenedBooks(); //load contacts from the database

    //call set state to change the displayed contacts
    if(rebuild == true) {
      setState(() {
        _books = books;
        _openedBooks = openedBooks;
      });
    }
  }

  scaleImageSize() {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    print("width: " + width.toString());
    print("height: " + height.toString());
  }
}
