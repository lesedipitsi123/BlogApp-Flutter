import 'package:blog_app/constants/strings.dart';
import 'package:blog_app/view/author/author_add_bottom_sheet.dart';
import 'package:blog_app/view/author/widgets/author_list_content.dart';
import 'package:flutter/material.dart';

class AuthorScreen extends StatefulWidget {
  const AuthorScreen({Key? key}) : super(key: key);

  @override
  State createState() => _AuthorScreenState();
}

class _AuthorScreenState extends State<AuthorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text(authorAppbarTitle),
      ),
      body: const SafeArea(
        child: AuthorListContent()
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 1,
        icon: const Icon(Icons.add),
        label: const Text(authorBtnFloatingAddNew),
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
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
