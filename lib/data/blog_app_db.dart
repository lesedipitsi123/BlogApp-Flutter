import 'package:blog_app/constants/constants.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

@singleton
class BlogAppDb {
  Future<Database> configureDatabase() async {
    final database = openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) {
        db.execute(_createAuthorTable);
        db.execute(_createBlogTable);
      },
      version: _databaseVersion,
    );

    return database;
  }

  static const int _databaseVersion = 1;
  static const String _databaseName = "blog_app_database";
  static const String _createAuthorTable =
      "CREATE TABLE ${Constants.authorTable}(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)";
  static const String _createBlogTable =
      "CREATE TABLE ${Constants.blogTable}(id INTEGER PRIMARY KEY AUTOINCREMENT, author INTEGER, title TEXT, description TEXT)";
}
