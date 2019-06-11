import 'package:flutter/material.dart';
import 'package:hintreader/views/BookView.dart';
import 'package:hintreader/BookCard.dart';

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
      Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //whole library
        new Expanded(child:
          bookGrid()),
        Row(
            children: <Widget>[
              Expanded(
                  child: Divider()
              ),

              Text("MOST RECENT"),

              Expanded(
                  child: Divider()
              ),
            ]
        ),
      //most recent
      new Container(
          height: 200.0, width: MediaQuery.of(context).size.width, child: recentBookGrid()),
        ],
      )
      //bottomNavigationBar: recentBookGrid(),
    );
  }

  bookGrid() {
    var xAC = 3;

    return GridView.count(
      crossAxisCount: xAC, //how many books per row
      children: List.generate(9, (index) {
        return bookGridItem(index);
      }),
    );
  }


  recentBookGrid() {
    return GridView.count(
      crossAxisCount: 1, //how many books per row
      scrollDirection: Axis.horizontal,
      children: List.generate(9, (index) {
        return bookGridItem(index);
      }),
    );
  }

  bookGridItem(int m) {
    return Container(
        constraints: BoxConstraints.loose(box),
        child: books[m % (books.length - 1)] == true
          ? BookCard("verticalLargeNoDarkmode.PNG", "Logik", "Immanuel Kant")
        : Image.asset("assets/main_icon.png",
        height: (height / 7),
        width: (width / 7),
    )
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

  scaleImageSize() {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    print("width: " + width.toString());
    print("height: "+ height.toString());
  }
}
