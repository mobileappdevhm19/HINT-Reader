import 'package:flutter/material.dart';
import 'package:hintreader/views/BookView.dart';
import 'package:hintreader/views/BookshelView.dart';
import 'package:hintreader/views/BookshelfView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Colors.grey[200],
      ),
      home: BookshelfView("My bookshelf"),
    );
  }
}


