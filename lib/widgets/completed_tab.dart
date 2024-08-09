import 'package:f24_notes_sphere/utils/text_styles.dart';
import 'package:flutter/material.dart';

import '../models/todo_model.dart';

class CompletedTab extends StatefulWidget {
  final List<TodoModel> completedTodos;
  const CompletedTab({
    super.key,
    required this.completedTodos,
  });

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "completed",
        style: AppTextStyles.appBody,
      ),
    );
  }
}
