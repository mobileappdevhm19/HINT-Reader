import 'package:flutter/material.dart';

class BookView extends StatefulWidget {
  BookView(this.title, this.darkmode);

  final String title;
  final bool darkmode;

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
            actions: <Widget>[
        // action button
        IconButton(
          icon: Icon(Icons.wb_sunny),
          color: widget.darkmode == false
              ? Colors.black : Colors.white,
          onPressed: () {
            widget.darkmode == false ?
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) =>
                    BookView("My Book", true)))
              : Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) =>
                    BookView("My Book", false)));
          },
        ),
      ]


        ),

      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait ?
              portraitOrientation()
              : landscapeOrientation();
        },
      ),

    );
  }



  portraitOrientation() {
    String pic = "assets/portrait2.jpg";
    if (widget.darkmode) {
      pic = "assets/main_icon.png";
    }

    return Container (
        child: Image.asset(pic,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        )
    );
  }

  landscapeOrientation() {

    String pic = "assets/landscape.jpeg";
    if (widget.darkmode) {
      pic = "assets/main_icon.png";
    }

    return Container (
        child: Image.asset(pic,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        )
    );
  }
}

