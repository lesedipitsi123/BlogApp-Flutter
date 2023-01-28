import 'package:blog_app/constants/constants.dart';
import 'package:blog_app/data/blog_app_db.dart';
import 'package:blog_app/data/model/author.dart';
import 'package:blog_app/data/model/author_with_blogs.dart';
import 'package:blog_app/data/model/blog.dart';
import 'package:injectable/injectable.dart';

abstract class AuthorService {
  Future<void> create(Author author);

  Future<void> update(Author author);

  Future<void> delete(Author author);

  Future<List<Author>> get();

  Future<Author> getById(int id);

  Future<AuthorWithBlogs> getAuthorWithBlogs(int id);

  Future<List<AuthorWithBlogs>> getAuthorsWithBlogs();

  Future<bool> hasRecords();
}

@LazySingleton(as: AuthorService)
class AuthorServiceImpl implements AuthorService {
  final BlogAppDb _blogAppDb;

  AuthorServiceImpl(this._blogAppDb);

  @override
  Future<void> create(Author author) async {
    final db = await _blogAppDb.configureDatabase();
    db.insert(Constants.authorTable, author.toMap());
  }

  @override
  Future<void> update(Author author) async {
    final db = await _blogAppDb.configureDatabase();
    db.update(Constants.authorTable, author.toMap(),
        where: "id = ?", whereArgs: [author.id]);
  }

  @override
  Future<void> delete(Author author) async {
    final db = await _blogAppDb.configureDatabase();
    db.delete(Constants.authorTable, where: "id = ?", whereArgs: [author.id]);
  }

  @override
  Future<List<Author>> get() async {
    final db = await _blogAppDb.configureDatabase();
    final query = await db.query(Constants.authorTable);

    return Author.fromMap(query);
  }

  @override
  Future<Author> getById(int id) async {
    final db = await _blogAppDb.configureDatabase();
    final query = await db.query(Constants.authorTable,
        limit: 1, where: "id = ?", whereArgs: [id]);

    return Author.fromSingleMap(query);
  }

  @override
  Future<AuthorWithBlogs> getAuthorWithBlogs(int id) async {
    final db = await _blogAppDb.configureDatabase();
    final queryAuthor = await db.query(Constants.authorTable,
        limit: 1, where: "id = ?", whereArgs: [id]);
    final queryBlogs = await db
        .query(Constants.blogTable, where: "authorId = ?", whereArgs: [id]);

    final author = Author.fromSingleMap(queryAuthor);
    final blogs = Blog.fromMap(queryBlogs);

    return AuthorWithBlogs(author: author, blogs: blogs);
  }

  @override
  Future<List<AuthorWithBlogs>> getAuthorsWithBlogs() async {
    final db = await _blogAppDb.configureDatabase();

    final query = await db.query(Constants.authorTable);

    List<AuthorWithBlogs> authorsWithBlogs = [];

    for (var item in query) {

      var author = Author.toAuthor(item);
      var blogs = List<Blog>.empty();

      if (author.id != null ) {
        final queryBlogs = await db
            .query(Constants.blogTable, where: "authorId = ?", whereArgs: [author.id]);
        blogs = Blog.fromMap(queryBlogs);
      }

      authorsWithBlogs.add(AuthorWithBlogs(author: author, blogs: blogs));
    }

    return authorsWithBlogs;
  }

  @override
  Future<bool> hasRecords() async {
    final db = await _blogAppDb.configureDatabase();
    final query = await db.rawQuery(
        "SELECT EXISTS(SELECT * FROM ${Constants.authorTable}) AS hasRecord");
    return query.first["hasRecord"] as bool;
  }
}
