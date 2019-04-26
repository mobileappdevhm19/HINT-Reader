import 'package:flutter/material.dart';
import 'package:hintreader/views/BookView.dart';

class BookshelView extends StatefulWidget {
  BookshelView(this.title);

  final String title;

  @override
  _BookshelViewState createState() => _BookshelViewState();
}

class _BookshelViewState extends State<BookshelView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
            child: ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child: FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) =>
                              BookView("My Book")));

                    },
                    child: Image.asset("assets/main_icon.png")))));
  }
}

/*Container(child: ConstrainedBox(
constraints: BoxConstraints.expand(),
child: FlatButton(onPressed: null,
child: Image.asset('path/the_image.png'))))*/
