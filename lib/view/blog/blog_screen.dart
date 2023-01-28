import 'package:blog_app/constants/routes.dart';
import 'package:blog_app/constants/strings.dart';
import 'package:blog_app/view/blog/widgets/blog_list_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BlogScreen extends StatefulWidget {
  final int authorId;
  final String authorName;

  const BlogScreen({required this.authorId, required this.authorName, Key? key})
      : super(key: key);

  @override
  State createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => {context.go("/")},
            icon: const Icon(Icons.arrow_back_ios)),
        elevation: 2,
        title: Text("${widget.authorName}'s blogs"),
      ),
      body: SafeArea(child: BlogListContent(authorId: widget.authorId)),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 1,
        icon: const Icon(Icons.add),
        label: const Text(blogBtnFloatingAddNew),
        onPressed: () {
        context.goNamed(blogAddScreenRouteName);
        },
      ),
    );
  }
}
