import 'package:blog_app/data/model/author.dart';
import 'package:blog_app/data/model/blog.dart';

class AuthorWithBlogs {
  final Author author;
  final List<Blog> blogs;

  AuthorWithBlogs({required this.author, required this.blogs});
}
