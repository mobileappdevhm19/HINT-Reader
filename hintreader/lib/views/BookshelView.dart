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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context)
              => BookView("My Book")));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}