class Author {
  final int? id;
  final String name;

  Author({
    this.id,
    required this.name
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name
    };
  }

  static List<Author> fromMap(List<Map<String, dynamic>> map) {
    List<Author> authors = [];

    for (var item in map) {
      authors.add(toAuthor(item));
    }

    return authors;
  }

  static Author fromSingleMap(List<Map<String, dynamic>> map) {
    final author = Author(id: map.first["id"], name: map.first["name"]);
    return author;
  }

  static Author toAuthor(Map<String, dynamic> map) {
    return Author(id: map["id"], name: map["name"]);
  }
}