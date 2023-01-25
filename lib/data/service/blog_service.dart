import 'package:blog_app/constants/constants.dart';
import 'package:blog_app/data/blog_app_db.dart';
import 'package:blog_app/data/model/blog.dart';
import 'package:injectable/injectable.dart';

abstract class BlogService {
  Future<void> create(Blog blog);

  Future<void> update(Blog blog);

  Future<void> delete(Blog blog);

  Future<List<Blog>> get();

  Future<Blog> getById(int id);

  Future<List<Blog>> getByAuthorId(int authorId);

  Future<bool> hasRecords();
}

@LazySingleton(as: BlogService)
class BlogServiceImpl implements BlogService {
  final BlogAppDb _blogAppDb;

  BlogServiceImpl(this._blogAppDb);

  @override
  Future<void> create(Blog blog) async {
    final db = await _blogAppDb.configureDatabase();
    db.insert(Constants.authorTable, blog.toMap());
  }

  @override
  Future<void> update(Blog blog) async {
    final db = await _blogAppDb.configureDatabase();
    db.update(Constants.blogTable, blog.toMap(),
        where: "id = ?s", whereArgs: [blog.id]);
  }

  @override
  Future<void> delete(Blog blog) async {
    final db = await _blogAppDb.configureDatabase();
    db.delete(Constants.blogTable, where: "id = ?s", whereArgs: [blog.id]);
  }

  @override
  Future<List<Blog>> get() async {
    final db = await _blogAppDb.configureDatabase();
    final query = await db.query(Constants.blogTable);

    return Blog.fromMap(query);
  }

  @override
  Future<List<Blog>> getByAuthorId(int authorId) async {
    final db = await _blogAppDb.configureDatabase();
    final query = await db.query(Constants.blogTable, limit: 1, where: "authorId = ?s", whereArgs: [authorId]);

    return Blog.fromMap(query);
  }

  @override
  Future<Blog> getById(int id) async {
    final db = await _blogAppDb.configureDatabase();
    final query = await db.query(Constants.blogTable, limit: 1, where: "id = ?s", whereArgs: [id]);

    return Blog.fromSingleMap(query);
  }

  @override
  Future<bool> hasRecords() async {
    final db = await _blogAppDb.configureDatabase();
    final query = await db.rawQuery(
        "SELECT EXISTS(SELECT * FROM ${Constants.authorTable}) AS hasRecord");
    return query.first["hasRecord"] as bool;
  }
}