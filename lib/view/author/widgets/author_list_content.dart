import 'package:blog_app/constants/dimens.dart';
import 'package:blog_app/constants/routes.dart';
import 'package:blog_app/constants/strings.dart';
import 'package:blog_app/data/model/author_with_blogs.dart';
import 'package:blog_app/view/author/author_add_bottom_sheet.dart';
import 'package:blog_app/view_model/author_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

enum ClickItem { edit, delete }

class AuthorListContent extends StatelessWidget {
  const AuthorListContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authorViewModel = context.read<AuthorViewModel>();
    authorViewModel.getAuthorsWithBlogs();

    return Selector<AuthorViewModel, List<AuthorWithBlogs>>(
      selector: (context, viewModel) => viewModel.authorsWithBlogs,
      builder: (context, authorsWithBlogs, child) {
        return authorsWithBlogs.isNotEmpty
            ? _authorsContent(context, authorsWithBlogs, authorViewModel)
            : _emptyAuthors(context);
      },
    );
  }

  Widget _authorsContent(BuildContext context,
      List<AuthorWithBlogs> authorsWithBlogs, AuthorViewModel authorViewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: ListView.builder(
          itemCount: authorsWithBlogs.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surfaceVariant,
              child: InkWell(
                onTap: () {
                  context.goNamed(blogScreenRouteName, params: {
                    'authorId': authorsWithBlogs[index].author.id.toString(),
                    'authorName': authorsWithBlogs[index].author.name
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(authorsWithBlogs[index].author.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${authorsWithBlogs[index].blogs.length} blogs",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant)),
                          PopupMenuButton<ClickItem>(
                            elevation: 2.0,
                            icon: const Icon(Icons.more_vert),
                            color: Theme.of(context).colorScheme.outline,
                            onSelected: (ClickItem item) async {
                              switch (item) {
                                case ClickItem.edit:
                                  showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16.0),
                                        ),
                                      ),
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        return AuthorBottomSheet(
                                            authorName: authorsWithBlogs[index]
                                                .author
                                                .name);
                                      });
                                  break;
                                case ClickItem.delete:
                                  showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title:
                                                const Text('Delete author'),
                                            content: const Text(
                                                'Are you sure?'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Cancel'),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  authorViewModel.removeAuthor(
                                                      authorsWithBlogs[index]
                                                          .author);

                                                  Navigator.pop(
                                                      context, 'Ok');
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ));

                                  break;
                              }
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<ClickItem>>[
                              const PopupMenuItem<ClickItem>(
                                  value: ClickItem.edit,
                                  child: ListTile(
                                    leading: Icon(Icons.edit_outlined),
                                    title: Text(authorBtnEdit),
                                  )),
                              const PopupMenuItem<ClickItem>(
                                value: ClickItem.delete,
                                child: ListTile(
                                  leading: Icon(Icons.delete_outline),
                                  title: Text(authorBtnDelete),
                                ),
                              ),
                            ],
                          )
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

  Widget _emptyAuthors(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person_add_alt),
          const Text(authorEmptyList),
          columnDivider16,
          OutlinedButton(
              child: const Text(authorBtnAddNew),
              onPressed: () => {
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16.0),
                          ),
                        ),
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return const AuthorBottomSheet();
                        })
                  })
        ],
      ),
    );
  }
}
