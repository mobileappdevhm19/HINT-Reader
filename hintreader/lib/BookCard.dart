import 'package:flutter/material.dart';
import 'package:hintreader/views/BookView.dart';
import 'package:hintreader/BookModel.dart';
import 'package:hintreader/database.dart';

/// A custom [Card] widget.
///
/// The widget is composed on an [Image], [FlatButton] and [Text]. Tapping on the widget you'll be
/// redirect to the BookView.
class BookCard extends StatelessWidget {
  String picture="";
  String title="n.a.";
  String author="n.a.";

  /// Creates a [Card].
  ///
  /// A [Category] saves the name of the Category (e.g. 'Length'), its color for
  /// the UI, and the icon that represents it (e.g. a ruler).
  // While the @required checks for whether a named parameter is passed in,
  // it doesn't check whether the object passed in is null. We check that
  // in the assert statement.
  BookCard(
      String picture,
      String title,
      String author,
      ) {
    this.picture = 'assets/' + picture;
    this.title = title;
    this.author = author;
  }

  /// Builds a custom widget that shows the [Card].
  ///
  /// This information includes the picture, title, and author for the [Card].
  @override
  // This `context` parameter describes the location of this widget in the
  // widget tree. It can be used for obtaining Theme data from the nearest
  // Theme ancestor in the tree. Below, we obtain the display1 text theme.
  // See https://docs.flutter.io/flutter/material/Theme-class.html
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        color: Colors.black,
        constraints: new BoxConstraints.expand(
          height: 127.0,
          width: 100,
        ),
        //padding: new EdgeInsets.only(left: 16.0, bottom: 8.0),
        child: ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.transparent],
            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
          },
          blendMode: BlendMode.dstIn,
          child: Image.asset(
            picture,
            fit: BoxFit.fill,
          ),
        ),
      ),
      Container(
          constraints: new BoxConstraints.expand(
            height: 127.0,
            width: 100,
          ),
          child: FlatButton(
            onPressed: () {
              _openTheBook();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          BookView("My Book", false, 0)));
            },
            child: Container(
                alignment: Alignment.bottomLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(title,
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                          color: Colors.white,
                          //fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        )),
                    Text(author,
                        style: new TextStyle(
                          color: Colors.white,
                          //fontWeight: FontWeight.bold,
                          fontSize: 8.0,
                        )),],)),
          ))
    ]);
  }

  _openTheBook() async {
    Book item = await DBProvider.db.getBook(title);
    await DBProvider.db.openBook(item);
  }
}