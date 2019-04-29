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
              child: Text("A", style: TextStyle(color: widget.size == -1 ? Colors.white : Colors.black,)),
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
              child: Text("a", style: TextStyle(color: widget.size == 1 ? Colors.white : Colors.black,)),
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
        pic = "assets/verticalNormalDarkmode.PNG";
      }
      else if (widget.size == -1) {
        pic = "assets/verticalLargeDarkmode.PNG";
      }
      else { //widget.size == 1
        pic = "assets/verticalSmallDarkmode.PNG";
      }
    } else { // no dark mode
      if (widget.size == 0) {
        pic = "assets/verticalNormalNoDarkmode.PNG";
      }
      else if (widget.size == -1) {
        pic = "assets/verticalLargeNoDarkmode.PNG";
      }
      else { //widget.size == 1
        pic = "assets/verticalSmallNoDarkmode.PNG";
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
        pic = "assets/horizontalNormalDarkmode.PNG";
      }
      else if (widget.size == -1) {
        pic = "assets/horizontalLargeDarkmode.PNG";
      }
      else { //widget.size == 1
        pic = "assets/horizontalSmallDarkmode.PNG";
      }
    } else { // no dark mode
      if (widget.size == 0) {
        pic = "assets/horizontalNormalNoDarkmode.PNG";
      }
      else if (widget.size == -1) {
        pic = "assets/horizontalLargeNoDarkmode.PNG";
      }
      else { //widget.size == 1
        pic = "assets/horizontalSmallNoDarkmode.PNG";
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
