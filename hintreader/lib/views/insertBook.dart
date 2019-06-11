import 'package:flutter/material.dart';
import 'package:hintreader/database.dart';
import 'package:hintreader/BookModel.dart';


class InsertBook extends StatefulWidget {
  @override
  InsertBookState createState() {
    return InsertBookState();
  }
}

class InsertBookState extends State<InsertBook> {
  var _title;
  var _author;
  static final _formKey = GlobalKey<FormState>();
  Key _k1 = new GlobalKey();
  Key _k2 = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Insert the new book"),),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
                key: _k1,
                decoration: InputDecoration(labelText: 'Title:'),
                validator: (v) {
                  if (v.isNotEmpty) _title = v;
                }),
            TextFormField(
                key: _k2,
                decoration: InputDecoration(labelText: 'Author:'),
                validator: (v) {
                  if (v.isNotEmpty) _author = v;
                }),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate())
                    _addBook(_title, _author, context);
                },
                child: Text('Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addBook(String title, String author, BuildContext context) {
    if (title == null || author == null)
      showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(title: Text("Type a valid title/author."));
          });
    else {
      DBProvider.db.newBook(Book(
          title: title,
          author: author,
          picture: "verticalLargeNoDarkmode.PNG"));
      Navigator.pop(context);
      setState(() {});
    }
  }
}

