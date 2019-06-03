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
  int id;
  String title;
  String author;
  String picture;
  //bool opened;

  Book({
    this.id,
    this.title,
    this.author,
    this.picture,
    //this.opened,
  });

  factory Book.fromMap(Map<String, dynamic> json) => new Book(
    id: json["id"],
    title: json["title"],
    author: json["author"],
    picture: json["picture"],
    //opened: json["opened"] == 1,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "author": author,
    "picture": picture,
    //"opened": opened,
  };
}
