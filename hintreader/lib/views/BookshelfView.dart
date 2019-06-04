import 'package:flutter/material.dart';
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

class _BookshelfState extends State<Bookshelf> {
  Size box = Size(200, 200);
  double width = 0;
  double height = 0;
  bool vertical = true;
  //List<Book> _books = new List<Book>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.delete_sweep, color: Colors.orange),
            onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return DeleteBook();
                    }),
                  )
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return InsertBook();
            }),
          );
        },
      ),
    );
  }

  verticalTable() {
    vertical = true;
    print("Vertical");
    scaleImageSize();
    DBProvider.db.loadBookFromJson(context);
    return Column(children: <Widget>[
      Container(
        constraints: new BoxConstraints.expand(
          height: 127.0,
        ),
        child: FutureBuilder<List<Book>>(
          future: DBProvider.db.getAllBooks(),
          builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Book item = snapshot.data[index];
                  return Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: BookCard(item.picture, item.title, item.author));
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    ]);
  }

  horizontalTable() {
    vertical = false;
    scaleImageSize();
    print("Horizontal");
    DBProvider.db.loadBookFromJson(context);
    return Column(
      children: <Widget>[
        Container(
          constraints: new BoxConstraints.expand(
            height: 127.0,
          ),
          child: FutureBuilder<List<Book>>(
            future: DBProvider.db.getAllBooks(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    Book item = snapshot.data[index];
                    return Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: BookCard(item.picture, item.title, item.author));
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }

  scaleImageSize() {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    print("width: " + width.toString());
    print("height: " + height.toString());
  }
}
