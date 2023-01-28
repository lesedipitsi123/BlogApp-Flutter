import 'package:blog_app/constants/strings.dart';
import 'package:flutter/material.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  State createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text(blogAppbarTitle),
      ),
    );
  }
}