import 'package:blog_app/data/model/author.dart';
import 'package:blog_app/data/service/author_service.dart';
import 'package:injectable/injectable.dart';

abstract class AuthorRepository {
  Future<void> create(Author author);

  Future<void> update(Author author);

  Future<void> delete(Author author);

  Future<List<Author>> get();

  Future<Author> getById(int id);

  Future<bool> hasRecords();
}

@LazySingleton(as: AuthorRepository)
class AuthorRepositoryImpl implements AuthorRepository {
  final AuthorService _service;

  AuthorRepositoryImpl(this._service);

  @override
  Future<void> create(Author author) => _service.create(author);

  @override
  Future<void> update(Author author) => _service.update(author);

  @override
  Future<void> delete(Author author) => _service.delete(author);

  @override
  Future<List<Author>> get() => _service.get();

  @override
  Future<Author> getById(int id) => _service.getById(id);

  @override
  Future<bool> hasRecords() => _service.hasRecords();
}
