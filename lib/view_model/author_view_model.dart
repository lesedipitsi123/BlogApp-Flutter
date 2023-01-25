import 'package:blog_app/data/model/author.dart';
import 'package:blog_app/data/repository/author_repository.dart';
import 'package:blog_app/setup_locator.dart';
import 'package:flutter/foundation.dart';

class AuthorViewModel extends ChangeNotifier {
  final AuthorRepository _repository = getIt<AuthorRepository>();
  List<Author> _authors = [];
  late Author _author;

  List<Author> get authors => _authors;

  Author get author => _author;

  Future<void> getAuthors() async {
    _authors = await _repository.get();
    notifyListeners();
  }

  Future<void> addNewAuthor(Author author) async {
    await _repository.create(author);
    notifyListeners();
  }

  Future<void> getAuthor(int id) async {
    _author = await _repository.getById(id);
    notifyListeners();
  }
}