import 'package:flutter/material.dart';

class BookView extends StatefulWidget {
  BookView(this.title);

  final String title;

  @override
  State<StatefulWidget> createState() => _BookViewState();
}

class _BookViewState extends  State<BookView> {
  _BookViewState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        ),
    );
  }
}