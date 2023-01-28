import 'package:blog_app/constants/dimens.dart';
import 'package:blog_app/constants/routes.dart';
import 'package:blog_app/constants/strings.dart';
import 'package:blog_app/data/model/blog.dart';
import 'package:blog_app/view_model/blog_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BlogListContent extends StatelessWidget {
  final int authorId;

  const BlogListContent({required this.authorId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blogViewModel = context.read<BlogViewModel>();
    blogViewModel.getBlogsByAuthor(authorId);

    return Selector<BlogViewModel, List<Blog>>(
      selector: (context, viewModel) => viewModel.blogs,
      builder: (context, blogs, child) {
        return blogs.isNotEmpty
            ? _blogsContent(context, blogs, blogViewModel)
            : _emptyBlogs(context);
      },
    );
  }

  Widget _emptyBlogs(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.bookmark_add_outlined),
          const Text(blogEmptyList),
          columnDivider16,
          OutlinedButton(
              child: const Text(blogBtnAddNew),
              onPressed: () {
                context.goNamed(blogAddScreenRouteName);
              })
        ],
      ),
    );
  }

  Widget _blogsContent(
      BuildContext context, List<Blog> blogs, BlogViewModel blogViewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: ListView.builder(
          itemCount: blogs.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surfaceVariant,
              child: InkWell(
                onTap: () {
                  context.goNamed(blogAddScreenRoute);
                },
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(blogs[index].title,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0)),
                        subtitle: Text(blogs[index].description),
                        leading: const Icon(Icons.book_outlined),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                              child: const Text(blogBtnEdit),
                              onPressed: () {
                                context.goNamed(blogViewScreenRouteName);
                              })
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
