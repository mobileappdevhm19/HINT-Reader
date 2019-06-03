import 'dart:convert';

Book BookFromJson(String str) {
  final jsonData = json.decode(str);
  return Book.fromMap(jsonData);
}

String BookToJson(Book data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Book {
  String title;
  String author;
  String picture;
  //bool opened;

  Book({
    this.title,
    this.author,
    this.picture,
    //this.opened,
  });

  factory Book.fromMap(Map<String, dynamic> json) => new Book(
    title: json["title"],
    author: json["author"],
    picture: json["picture"],
    //opened: json["opened"] == 1,
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "author": author,
    "picture": picture,
    //"opened": opened,
  };
}
