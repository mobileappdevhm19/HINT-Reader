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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.delete_sweep, color: Colors.orange),
            onPressed: () =>
            {
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
                                DBProvider.db.deleteAll();
                                _getBooks();
                                setState(() {});
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
                              );
                              _getBooks();
                              setState(() {});
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
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? verticalTable()
              : horizontalTable();
        },
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
                          _getBooks(true);
                          setState(() {});
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
                          );
                          _getBooks();
                          setState(() {});
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return Scaffold();
                            }),
                          );
                          Navigator.pop(context);
                        },
                        child: Text('Add a new book'),
                      ),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }

  verticalTable() {
    vertical = true;
    print("Vertical");
    scaleImageSize();
    //DBProvider.db.loadBookFromJson(context);
    return Container(
        constraints: new BoxConstraints.expand(
          height: 127.0,
        ),
        child: (_books!=null && _books.length >0) ?
        ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _books.length,
          itemBuilder: (BuildContext context, int index) {
            Book item = _books[index];
            return Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: BookCard(item.picture, item.title, item.author));
          },
        )
            : Center(child: CircularProgressIndicator())
    );
  }

  horizontalTable() {
    vertical = false;
    scaleImageSize();
    print("Horizontal");
    return Container(
        constraints: new BoxConstraints.expand(
          height: 127.0,
        ),
        child: (_books!=null && _books.length >0) ?
        ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _books.length,
          itemBuilder: (BuildContext context, int index) {
            Book item = _books[index];
            return Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: BookCard(item.picture, item.title, item.author));
          },
        )
            : Center(child: CircularProgressIndicator())
    );
  }

  //use this method to do something after the screen was build the first time
  @override
  void afterFirstLayout(BuildContext context) {
    DBProvider.db.loadBookFromJson(context);
  }

  //get all the books
  Future<void> _getBooks([bool update = false]) async {
    List<Book> books = new List<Book>(); //create a empty list
    if (update) {
      //if update is marked
      await DBProvider.db.updateBooks(
          context); //fetch data from the json and update database
    }
    books = await DBProvider.db.getAllBooks(); //load contacts from the database

    //call set state to change the displayed contacts
    setState(() {
      _books = books;
    });
  }

  scaleImageSize() {
    width = MediaQuery
        .of(context)
        .size
        .width;
    height = MediaQuery
        .of(context)
        .size
        .height;

    print("width: " + width.toString());
    print("height: " + height.toString());
  }
}
