import 'package:blog_app/data/model/author.dart';
import 'package:blog_app/data/model/author_with_blogs.dart';
import 'package:blog_app/data/repository/author_repository.dart';
import 'package:blog_app/setup_locator.dart';
import 'package:flutter/foundation.dart';

class AuthorViewModel extends ChangeNotifier {
  final AuthorRepository _repository = getIt<AuthorRepository>();
  List<Author> _authors = [];
  List<AuthorWithBlogs> _authorsWithBlogs = [];
  late Author _author;

  List<Author> get authors => _authors;
  List<AuthorWithBlogs> get authorsWithBlogs => _authorsWithBlogs;

  Author get author => _author;

  Future<void> getAuthors() async {
    _authors = await _repository.get();
    notifyListeners();
  }

  Future<void> getAuthorsWithBlogs() async {
    _authorsWithBlogs = await _repository.getAuthorsWithBlogs();
    notifyListeners();
  }

  Future<void> addNewAuthor(Author author) async {
    await _repository.create(author);
    _authors = await _repository.get();
    _authorsWithBlogs = await _repository.getAuthorsWithBlogs();
    notifyListeners();
  }

  Future<void> getAuthor(int id) async {
    _author = await _repository.getById(id);
    notifyListeners();
  }

  Future<void> removeAuthor(Author author) async {
    await _repository.delete(author);
    _authors = await _repository.get();
    _authorsWithBlogs = await _repository.getAuthorsWithBlogs();
    notifyListeners();
  }
}
