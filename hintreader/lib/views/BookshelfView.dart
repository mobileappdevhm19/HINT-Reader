import 'package:flutter/material.dart';
import 'package:hintreader/BookCard.dart';
import 'package:hintreader/BookModel.dart';
import 'package:hintreader/database.dart';

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

  var books = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  int book = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.delete_sweep, color: Colors.orange),
            onPressed: () => {
              setState(() {DBProvider.db.deleteBook("Logik");})
            },
          )
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
        onPressed: () async {
          Book rnd = Book(title: "Logik", author: "Immanuel Kant", picture: "verticalLargeNoDarkmode.PNG");
          await DBProvider.db.newBook(rnd);
          setState(() {});
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
                  ? BookCard(
                      "verticalLargeNoDarkmode.PNG", "Logik", "Immanuel Kant")
                  : Image.asset(
                      "assets/main_icon.png",
                      height: (height / 7),
                      width: (width / 7),
                    ))
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
    vertical == false ? book = book % 3 : book = book;
    if (m) {
      return TableRow(
          decoration: new BoxDecoration(
            color: Colors.grey,
          ),
          children: [
            newBookCell(book++),
            newBookCell(book++),
            newBookCell(book++),
          ]);
    } else {
      return TableRow(children: [
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
    } else {
      return TableRow(children: [
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
    return Column(children: <Widget>[
      Table(border: TableBorder.all(width: 0.0, color: Colors.grey), children: [
        newBookRow(false),
        newInfoRow(false),
        newBookRow(false),
        newInfoRow(false),
      ]),
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
                  return BookCard(item.picture, item.title, item.author);
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      /*Table(
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
          ]),*/
      /*Table(
          border: TableBorder.all(width: 0.0, color: Colors.blueGrey),
          children: [
            newBookRow(true),
            newInfoRow(true),
          ]),*/
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
    print("height: " + height.toString());
  }
}
