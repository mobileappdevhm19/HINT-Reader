import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hintreader/nasaPicture.dart';
import 'package:http/http.dart' as http;

class nasaApi extends StatelessWidget {

  final String apiUrl = "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY";


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Http App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
        child: FutureBuilder<NasaPicture> (
          future: getPost(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return ErrorWidget("Error!");
              }
              return Image.network('${snapshot.data.url}');
            }
            else
              return CircularProgressIndicator();
          },
        ),
    )));
  }


//  @override
//  State<StatefulWidget> createState() {
    // TODO: implement createState
//    FutureBuilder<NasaPicture> {
//      future: getPost(),
//      builder: (context, snapshot) {
//        return Text('${snapshot.data.title}');
//      }};
//    return null;
//  }

  NasaPicture nasaPictureFromJson(String str) {
    final jsonData = json.decode(str);
    return NasaPicture.fromJson(jsonData);
  }

  Future<NasaPicture> getPost() async {
    final response = await http.get(apiUrl);
    return nasaPictureFromJson(response.body);
  }
}