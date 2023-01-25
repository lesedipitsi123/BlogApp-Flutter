import 'package:flutter/material.dart';

class DragHandle extends StatelessWidget {
  const DragHandle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5.0,
      width: 36.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).colorScheme.surface),
    );
  }
}
