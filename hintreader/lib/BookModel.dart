import 'dart:convert';

BookFactory bookFactoryFromJson(String str) {
  final jsonData = json.decode(str);
  return BookFactory.fromJson(jsonData);
}

String bookFactoryToJson(Book data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

//Use the contact factory to create a list of contacts out of a valid json string
class BookFactory {
  List<Book> books;

  BookFactory({
    this.books,
  });

  factory BookFactory.fromJson(Map<String, dynamic> json) => new BookFactory(
    books: new List<Book>.from(json["books"].map((x) => Book.fromMap(x))),
  );

  Map<String, dynamic> toJson() => {
    "books": new List<dynamic>.from(books.map((x) => x.toMap())),
  };
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
