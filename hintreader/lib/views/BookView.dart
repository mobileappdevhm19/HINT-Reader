import 'package:flutter/material.dart';
import 'package:hintreader/progbar/MyLinearProgressIndicator.dart';

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

  static Map<int, Color> color =
  {
    50:Color.fromRGBO(255,156,6, .1),
    100:Color.fromRGBO(255,156,6, .2),
    200:Color.fromRGBO(255,156,6, .3),
    300:Color.fromRGBO(255,156,6, .4),
    400:Color.fromRGBO(255,156,6, .5),
    500:Color.fromRGBO(255,156,6, .6),
    600:Color.fromRGBO(255,156,6, .7),
    700:Color.fromRGBO(255,156,6, .8),
    800:Color.fromRGBO(255,156,6, .9),
    900:Color.fromRGBO(255,156,6, 1),
  };

  MaterialColor colorCustom = MaterialColor(0xFFFF9C06, color);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          bottom: MyLinearProgressIndicator(
            backgroundColor: colorCustom,
            value: calculateProgressBar(),
          ),
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.wb_sunny),
              color: darkmode == false ? colorCustom : Colors.black,
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
              child: Text("A", style: TextStyle(color: size == -1 ? Colors.black : colorCustom, fontSize: 28)),
              color: Colors.grey[200],
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
              child: Text("a", style: TextStyle(color: size == 1 ? Colors.black : colorCustom, fontSize: 28)),
              color: Colors.grey[200],
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
    scaleImageSize();
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
        Image.asset(pic, fit: BoxFit.cover, height: 650, alignment: Alignment.center,),
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

  scaleImageSize() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    print("width: " + width.toString());
    print("height: "+ height.toString());
  }

  landscapeOrientation() {
    scaleImageSize();
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
        Image.asset(pic, fit: BoxFit.cover, height: 350, alignment: Alignment.center,),
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

  calculateProgressBar() {
    return 0.335;
  }
}
