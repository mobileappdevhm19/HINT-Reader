import 'package:flutter/material.dart';
import 'package:hintreader/database.dart';

class DeleteBook extends StatefulWidget {
  @override
  DeleteBookState createState() {return DeleteBookState();
  }
}
class DeleteBookState extends State<DeleteBook> {
  var _title;
  static final _formKey = GlobalKey<FormState>();
  Key _k1 = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Delete the new book"),),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate())
                    _deleteBook(_title, context);
                },
                child: Text('delete'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteBook(String title, BuildContext context) {
    if (title == null)
      showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(title: Text("Type a valid title."));
          });
    else {
      DBProvider.db.deleteBook(title);
      Navigator.pop(context);
    }
  }
}

