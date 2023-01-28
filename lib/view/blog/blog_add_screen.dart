import 'package:blog_app/constants/dimens.dart';
import 'package:blog_app/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BlogAddScreen extends StatefulWidget {
  const BlogAddScreen({Key? key}) : super(key: key);

  @override
  State<BlogAddScreen> createState() => _BlogAddScreenState();
}

class _BlogAddScreenState extends State<BlogAddScreen> {
  final TextEditingController blogTitleController = TextEditingController();
  final TextEditingController blogDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => {context.go("/")},
            icon: const Icon(Icons.arrow_back_ios)),
        elevation: 2,
        title: const Text(blogNewAppbarTitle),
      ),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextFormField(
              controller: blogTitleController,
              maxLines: 1,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: blogTitleTextInput,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
              ),
            ),
            columnDivider24,
            TextFormField(
              controller: blogDescriptionController,
              minLines: 3,
              maxLines: 7,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                floatingLabelAlignment: FloatingLabelAlignment.start,
                labelText: blogDescriptionTextInput,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
              ),
            ),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 1,
        icon: const Icon(Icons.check),
        label: const Text(blogBtnFloatingDone),
        onPressed: () {
        },
      ),
    );
  }
}
