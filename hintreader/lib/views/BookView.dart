import 'package:flutter/material.dart';

class BookView extends StatefulWidget {
  BookView(this.title, this.darkmode, this.size);

  final String title;
  bool darkmode;
  int size; //-1 = zoomed in; 0 = normal; 1 = zoomed out

  @override
  State<StatefulWidget> createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
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
              color: widget.darkmode == false ? Colors.black : Colors.white,
              onPressed: () {
                if (widget.darkmode == false) {
                  setState(() {
                    widget.darkmode = true;
                  });
                } else {
                  setState(() {
                    widget.darkmode = false;
                  });
                }
              },
            ),
            RaisedButton(
              child: const Text("A"),
              color: Colors.blue,
              onPressed: () {
                if(widget.size == 0 || widget.size == 1) {
                  setState(() {
                    widget.size = -1;
                  });
                } else {
                  setState(() {
                    widget.size = 0;
                  });
                }
              },
            ),
            RaisedButton(
              child: const Text("a"),
              color: Colors.blue,
              onPressed: () {
                if(widget.size == 0 || widget.size == -1) {
                  setState(() {
                    widget.size = 1;
                  });
                } else {
                  setState(() {
                    widget.size = 0;
                  });
                }
              },
            )
          ]),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? portraitOrientation()
              : landscapeOrientation();
        },
      ),
    );
  }

  portraitOrientation() {
    String pic;
    if (widget.darkmode) {
      if (widget.size == 0) {
        pic = "assets/main_icon.png";
      }
      else if (widget.size == -1) {
        pic = "assets/landscape_zoomin.jpg";
      }
      else { //widget.size == 1
        pic = "assets/landscape_zoomout.JPG";
      }
    } else { // no dark mode
      if (widget.size == 0) {
        pic = "assets/portrait2.jpg";
      }
      else if (widget.size == -1) {
        pic = "assets/landscape_zoomin.jpg";
      }
      else { //widget.size == 1
        pic = "assets/landscape_zoomout.JPG";
      }
    }

    return Container(
        child: Image.asset(
      pic,
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    ));
  }

  landscapeOrientation() {
    String pic;
    if (widget.darkmode) {
      if (widget.size == 0) {
        pic = "assets/main_icon.png";
      }
      else if (widget.size == -1) {
        pic = "assets/landscape_zoomin.jpg";
      }
      else { //widget.size == 1
        pic = "assets/landscape_zoomout.JPG";
      }
    } else { // no dark mode
      if (widget.size == 0) {
        pic = "assets/landscape.jpeg";
      }
      else if (widget.size == -1) {
        pic = "assets/landscape_zoomin.jpg";
      }
      else { //widget.size == 1
        pic = "assets/landscape_zoomout.JPG";
      }
    }

    return Container(
        child: Image.asset(
      pic,
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    ));
  }
}
