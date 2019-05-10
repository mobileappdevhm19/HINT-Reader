import 'package:flutter/material.dart';
import 'package:hintreader/views/BookView.dart';

class BookshelfView extends StatefulWidget {
  BookshelfView(this.title);

  final String title;

  @override
  _BookshelfViewState createState() => _BookshelfViewState();
}

class _BookshelfViewState extends State<BookshelfView> {

  Size box = Size(200,200);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
            child: ConstrainedBox(
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
        )
    );
  }
}

/*Container(child: ConstrainedBox(
constraints: BoxConstraints.expand(),
child: FlatButton(onPressed: null,
child: Image.asset('path/the_image.png'))))*/
