import 'package:blog_app/constants/dimens.dart';
import 'package:blog_app/constants/strings.dart';
import 'package:blog_app/data/model/author.dart';
import 'package:blog_app/view/author/author_add_bottom_sheet.dart';
import 'package:blog_app/view_model/author_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ClickItem { edit, delete }

class AuthorListContent extends StatelessWidget {
  const AuthorListContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authorViewModel = context.read<AuthorViewModel>();
    authorViewModel.getAuthors();

    return Selector<AuthorViewModel, List<Author>>(
      selector: (context, viewModel) => viewModel.authors,
      builder: (context, authors, child) {
        return authors.isNotEmpty
            ? _authorsContent(context, authors, authorViewModel)
            : _emptyAuthors(context);
      },
    );
  }

  Widget _authorsContent(BuildContext context, List<Author> authors,
      AuthorViewModel authorViewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: ListView.builder(
          itemCount: authors.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surfaceVariant,
              child: InkWell(
                onTap: () {

                },
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(authors[index].name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("0 blogs",
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
                                            authorName: authors[index].name);
                                      });
                                  break;
                                case ClickItem.delete:
                                  authorViewModel.removeAuthor(authors[index]);
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
