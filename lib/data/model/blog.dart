class Blog {
  final int? id;
  final int authorId;
  final String title;
  final String description;

  Blog(
      {this.id,
      required this.authorId,
      required this.title,
      required this.description});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "authorId": authorId,
      "title": title,
      "description": description
    };
  }

  static List<Blog> fromMap(List<Map<String, dynamic>> map) {
    List<Blog> blogs = [];

    for (var item in map) {
      blogs.add(Blog(
          id: item["id"],
          authorId: item["authorId"],
          title: item["title"],
          description: item["description"]));
    }

    return blogs;
  }

  static Blog fromSingleMap(List<Map<String, dynamic>> map) {
    final blog = Blog(
        id: map.first["id"],
        authorId: map.first["authorId"],
        title: map.first["title"],
        description: map.first["description"]);

    return blog;
  }
}
