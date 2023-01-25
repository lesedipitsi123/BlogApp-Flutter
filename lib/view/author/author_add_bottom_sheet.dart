import 'package:blog_app/constants/dimens.dart';
import 'package:blog_app/constants/strings.dart';
import 'package:blog_app/data/model/author.dart';
import 'package:blog_app/view/widgets/drag_handle_widget.dart';
import 'package:blog_app/view_model/author_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorBottomSheet extends StatefulWidget {
  final String? authorName;

  const AuthorBottomSheet({Key? key, this.authorName}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthorBottomSheetState();
}

class _AuthorBottomSheetState extends State<AuthorBottomSheet> {
  late final AuthorViewModel _authorViewModel;
  final TextEditingController authorNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authorViewModel = context.read<AuthorViewModel>();
    authorNameController.text = widget.authorName ?? "";
  }

  @override
  void dispose() {
    authorNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 10,
                left: 24,
                right: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(children: [
              const DragHandle(),
              columnDivider16,
              TextFormField(
                controller: authorNameController,
                maxLines: 1,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: authorNameTextInput,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                ),
              ),
              columnDivider16,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(btnCancel),
                  ),
                  TextButton(
                    onPressed: () {
                      _authorViewModel.addNewAuthor(
                          Author(name: authorNameController.text));
                      ScaffoldMessenger.of(context).showSnackBar(
                          showSnackBar(authorSnackbarSaveSuccess));
                      Navigator.pop(context);
                    },
                    child: const Text(btnSave),
                  )
                ],
              ),
              columnDivider16,
            ]),
          )
        ]);
  }

  SnackBar showSnackBar(String message) {
    return SnackBar(
      content: Text(message),
    );
  }
}
