import 'package:blog_app/data/model/blog.dart';
import 'package:blog_app/data/service/blog_service.dart';
import 'package:injectable/injectable.dart';

abstract class BlogRepository {
  Future<void> create(Blog blog);

  Future<void> update(Blog blog);

  Future<void> delete(Blog blog);

  Future<List<Blog>> get();

  Future<Blog> getById(int id);

  Future<List<Blog>> getByAuthorId(int authorId);

  Future<bool> hasRecords();
}

@LazySingleton(as: BlogRepository)
class BlogRepositoryImpl implements BlogRepository {
  final BlogService _service;

  BlogRepositoryImpl(this._service);

  @override
  Future<void> create(Blog blog) => _service.create(blog);

  @override
  Future<void> update(Blog blog) => _service.update(blog);

  @override
  Future<void> delete(Blog blog) => _service.delete(blog);

  @override
  Future<List<Blog>> get() => _service.get();

  @override
  Future<List<Blog>> getByAuthorId(int authorId) => _service.getByAuthorId(authorId);

  @override
  Future<Blog> getById(int id) => _service.getById(id);

  @override
  Future<bool> hasRecords() => _service.hasRecords();
}
