import 'package:flutter/material.dart';
import 'package:hintreader/views/BookView.dart';

class Bookshelf extends StatefulWidget {
  Bookshelf(this.title);

  final String title;

  @override
  _BookshelfState createState() => _BookshelfState();
}

class _BookshelfState extends State<Bookshelf> {

  Size box = Size(200,200);

  var books=["assets/main_icon.png", "assets/main_icon.png", "assets/main_icon.png"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: Table(
            border: TableBorder.all(width: 1.0, color: Colors.black),
            children: [
              TableRow(children: [
                newTableCell(),
                newTableCell(),
                newTableCell(),
              ])

          ]),

        )
    );
  }

  newTableCell() {
    return TableCell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ConstrainedBox(
              constraints: BoxConstraints.loose(box),
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) =>
                            BookView("My Book", false, 0)));

                  },
                  child: Image.asset("assets/main_icon.png")
              )
          )
        ],
      ),
    );
  }
}

/*Container(child: ConstrainedBox(
constraints: BoxConstraints.expand(),
child: FlatButton(onPressed: null,
child: Image.asset('path/the_image.png'))))*/
