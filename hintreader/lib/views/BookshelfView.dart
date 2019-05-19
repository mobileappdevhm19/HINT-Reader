import 'package:flutter/material.dart';
import 'package:hintreader/views/BookView.dart';

class Bookshelf extends StatefulWidget {
  Bookshelf(this.title);

  final String title;

  @override
  _BookshelfState createState() => _BookshelfState();
}

class _BookshelfState extends State<Bookshelf> {

  Size box = Size(200, 200);
  double width = 0;
  double height= 0;
  bool vertical = true;

  var books = [
    true, false, false, false, false, false, false, false, false, false];
  int book = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:
      OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? verticalTable()
              : horizontalTable();
        },
      ),
    );
  }

  newBookCell(int m) {
    return TableCell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
              constraints: BoxConstraints.loose(box),
              child: books[m % (books.length - 1)] == true
                  ? FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) =>
                            BookView("My Book", false, 0)));
                  },
                  child:
                  Image.asset("assets/book-stack.png",
                    height: (height / 7),
                    width: (width / 7),
                  )
              )
                  : Image.asset("assets/main_icon.png",
                height: (height / 7),
                width: (width / 7),
              )
          )
        ],
      ),
    );
  }

  newDescriptionCell() {
    return TableCell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints.loose(box),
            child: Text("\nTitle\nAuthor\n"),
          )
        ],
      ),
    );
  }

  newBookRow(bool m) {
    vertical == false
    ? book = book % 3
    : book = book;
    if (m) {
      return TableRow(
          decoration: new BoxDecoration(
            color: Colors.grey,
          ),
          children: [
            newBookCell(book++),
            newBookCell(book++),
            newBookCell(book++),
          ]
      );
    }
    else {
      return TableRow(
          children: [
            newBookCell(book++),
            newBookCell(book++),
            newBookCell(book++),
          ]);
    }
  }

  newInfoRow(bool m) {
    if (m) {
      return TableRow(
          decoration: new BoxDecoration(
            color: Colors.grey,
          ),
          children: [
            newDescriptionCell(),
            newDescriptionCell(),
            newDescriptionCell(),
          ]);
    }
    else {
      return TableRow(
          children: [
            newDescriptionCell(),
            newDescriptionCell(),
            newDescriptionCell(),
          ]);
    }
  }

  verticalTable() {
    vertical = true;
    book = 0;
    print("Vertical");
    scaleImageSize();
    return Column(
        children: <Widget>[
          Table(
              border: TableBorder.all(width: 0.0, color: Colors.grey),
              children: [
                newBookRow(false),
                newInfoRow(false),
                newBookRow(false),
                newInfoRow(false),
              ]),
          Table(
              border: TableBorder.all(width: 1.0, color: Colors.black),
              children: [
                TableRow(
                    decoration: new BoxDecoration(
                      color: Colors.grey,
                    ),
                    children: [
                      TableCell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ConstrainedBox(
                              constraints: BoxConstraints.loose(box),
                              child: Text("\nMost Recent\n"),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ]),
          Table(
              border: TableBorder.all(width: 0.0, color: Colors.blueGrey),
              children: [
                newBookRow(true),
                newInfoRow(true),
              ]),
        ]);
  }

  horizontalTable() {
    vertical = false;
    book = 0;
    scaleImageSize();
    print("Horizontal");
    return Column(
      children: <Widget>[
        Table(
            border: TableBorder.all(width: 1.0, color: Colors.black),
            children: [
              TableRow(
                  decoration: new BoxDecoration(
                    color: Colors.grey,
                  ),
                  children: [
                    TableCell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ConstrainedBox(
                            constraints: BoxConstraints.loose(box),
                            child: Text("\nMost Recent\n"),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ]),
        Table(
            border: TableBorder.all(width: 0.0, color: Colors.blueGrey),
            children: [
              newBookRow(true),
              newInfoRow(true),
            ]),
      ],
    );
  }

  scaleImageSize() {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    print("width: " + width.toString());
    print("height: "+ height.toString());
  }
}
