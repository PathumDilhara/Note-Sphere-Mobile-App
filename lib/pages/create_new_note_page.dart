import 'package:flutter/material.dart';

class CreateNewNotePage extends StatefulWidget {
  final bool isNewCategory;
  const CreateNewNotePage({
    super.key,
    required this.isNewCategory,
  });

  @override
  State<CreateNewNotePage> createState() => _CreateNewNotePageState();
}

class _CreateNewNotePageState extends State<CreateNewNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isNewCategory.toString(),
        ),
      ),
    );
  }
}
