import 'package:blog_app/setup_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:blog_app/data/model/blog.dart';
import 'package:blog_app/data/repository/blog_repository.dart';

class BlogViewModel extends ChangeNotifier {
  final BlogRepository _repository = getIt<BlogRepository>();

  List<Blog> _blogs = [];
  late Blog _blog;

  List<Blog> get blogs => _blogs;

  Blog get blog => _blog;

  Future<void> getBlogs() async {
    _blogs = await _repository.get();
    notifyListeners();
  }

  Future<void> getBlog(int id) async {
    _blog = await _repository.getById(id);
    notifyListeners();
  }

  Future<void> getBlogsByAuthor(int authorId) async {
    _blogs = await _repository.getByAuthorId(authorId);
    notifyListeners();
  }

  Future<void> addNewBlog(Blog blog) async {
    _blogs.add(blog);
    await _repository.create(blog);
    notifyListeners();
  }

  Future<void> updateBlog(Blog blog) async {
    final index = _blogs.indexWhere((element) => element.id == blog.id);
    _blogs[index] = blog;
    await _repository.update(blog);
    notifyListeners();
  }

  Future<void> removeBlog(Blog blog) async {
    _blogs.removeWhere((element) => element.id == blog.id);
    await _repository.delete(blog);
    notifyListeners();
  }
}
