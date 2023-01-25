import 'package:blog_app/constants/dimens.dart';
import 'package:blog_app/constants/strings.dart';
import 'package:blog_app/data/model/author.dart';
import 'package:blog_app/view/author/author_add_bottom_sheet.dart';
import 'package:blog_app/view_model/author_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorListContent extends StatelessWidget {
  const AuthorListContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<AuthorViewModel, List<Author>>(
      selector: (context, viewModel) => viewModel.authors,
      builder: (context, authors, child) {
        return authors.isNotEmpty ? _authorsContent(context, authors) : _emptyAuthors(context);
      },
    );
  }

  Widget _authorsContent(BuildContext context, List<Author> authors) {
    return ListView.builder(
        itemCount: authors.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 0,
            color: Theme.of(context).colorScheme.surfaceVariant,
            child: Column(
              children: [
                ListTile(
                    leading: const Icon(Icons.person_outline_outlined),
                    title: Text(authors[index].name, style: const TextStyle(fontWeight: FontWeight.bold))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: () {
                      showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16.0),
                            ),
                          ),
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return AuthorBottomSheet(authorName: authors[index].name);
                          });
                    },
                        icon: const Icon(Icons.edit))
                  ],
                )
              ],
            ),
          );
        });
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
