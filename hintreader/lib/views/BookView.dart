import 'package:flutter/material.dart';

class BookView extends StatefulWidget {
  BookView(this.title, this.darkmode, this.size);

  final String title;
  bool darkmode;
  int size; //-1 = zoomed in; 0 = normal; 1 = zoomed out

  @override
  State<StatefulWidget> createState() => _BookViewState(darkmode, size);
}

class _BookViewState extends State<BookView> {
  _BookViewState(this.darkmode, this.size);

  bool darkmode;
  int size;

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
              color: darkmode == false ? Colors.black : Colors.white,
              onPressed: () {
                if (darkmode == false) {
                  setState(() {
                    darkmode = true;
                  });
                } else {
                  setState(() {
                    darkmode = false;
                  });
                }
              },
            ),
            RaisedButton(
              child: Text("A", style: TextStyle(color: size == -1 ? Colors.white : Colors.black,)),
              color: Colors.blue,
              onPressed: () {
                if(size == 0 || size == 1) {
                  setState(() {
                    size = -1;
                  });
                } else {
                  setState(() {
                    size = 0;
                  });
                }
              },
            ),
            RaisedButton(
              child: Text("a", style: TextStyle(color: size == 1 ? Colors.white : Colors.black,)),
              color: Colors.blue,
              onPressed: () {
                if(size == 0 || size == -1) {
                  setState(() {
                    size = 1;
                  });
                } else {
                  setState(() {
                    size = 0;
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
    if (darkmode) {
      if (size == 0) {
        pic = "assets/verticalNormalDarkmode.PNG";
      }
      else if (size == -1) {
        pic = "assets/verticalLargeDarkmode.PNG";
      }
      else { //size == 1
        pic = "assets/verticalSmallDarkmode.PNG";
      }
    } else { // no dark mode
      if (size == 0) {
        pic = "assets/verticalNormalNoDarkmode.PNG";
      }
      else if (size == -1) {
        pic = "assets/verticalLargeNoDarkmode.PNG";
      }
      else { //size == 1
        pic = "assets/verticalSmallNoDarkmode.PNG";
      }
    }

    final listView = ListView(
      scrollDirection: Axis.vertical,
      //padding: EdgeInsets.all(8.0),
      children: <Widget>[
        Image.asset(pic, fit: BoxFit.cover, alignment: Alignment.center,),
        Image.asset(pic, fit: BoxFit.cover, alignment: Alignment.center,),
        Image.asset(pic, fit: BoxFit.cover, alignment: Alignment.center,),
        Image.asset(pic, fit: BoxFit.cover, alignment: Alignment.center,),
        Image.asset(pic, fit: BoxFit.cover, alignment: Alignment.center,),
        Image.asset(pic, fit: BoxFit.cover, alignment: Alignment.center,),
        Image.asset(pic, fit: BoxFit.cover, alignment: Alignment.center,),
        Image.asset(pic, fit: BoxFit.cover, alignment: Alignment.center,),
      ],
    );

    return Container(
        child: listView);
  }

  landscapeOrientation() {
    String pic;
    if (darkmode) {
      if (size == 0) {
        pic = "assets/horizontalNormalDarkmode.PNG";
      }
      else if (size == -1) {
        pic = "assets/horizontalLargeDarkmode.PNG";
      }
      else { //size == 1
        pic = "assets/horizontalSmallDarkmode.PNG";
      }
    } else { // no dark mode
      if (size == 0) {
        pic = "assets/horizontalNormalNoDarkmode.PNG";
      }
      else if (size == -1) {
        pic = "assets/horizontalLargeNoDarkmode.PNG";
      }
      else { //size == 1
        pic = "assets/horizontalSmallNoDarkmode.PNG";
      }
    }

    final listView = ListView(
      scrollDirection: Axis.vertical,
      //padding: EdgeInsets.all(8.0),
      children: <Widget>[
        Image.asset(pic, fit: BoxFit.cover, alignment: Alignment.center,),
        Image.asset(pic, fit: BoxFit.cover, alignment: Alignment.center,),
        Image.asset(pic, fit: BoxFit.cover, alignment: Alignment.center,),
        Image.asset(pic, fit: BoxFit.cover, alignment: Alignment.center,),
        Image.asset(pic, fit: BoxFit.cover, alignment: Alignment.center,),
        Image.asset(pic, fit: BoxFit.cover, alignment: Alignment.center,),
        Image.asset(pic, fit: BoxFit.cover, alignment: Alignment.center,),
        Image.asset(pic, fit: BoxFit.cover, alignment: Alignment.center,),
      ],
    );

    return Container(
        child: listView);
  }
}
