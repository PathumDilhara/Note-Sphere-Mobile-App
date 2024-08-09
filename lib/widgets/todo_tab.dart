import 'package:f24_notes_sphere/utils/text_styles.dart';
import 'package:f24_notes_sphere/widgets/todo_card.dart';
import 'package:flutter/material.dart';

import '../models/todo_model.dart';

class TodoTab extends StatefulWidget {
  final List<TodoModel> inCompletedTodos;
  const TodoTab({
    super.key,
    required this.inCompletedTodos,
  });

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: widget.inCompletedTodos.length,
            itemBuilder: (context, index) {
              final TodoModel todo = widget.inCompletedTodos[index];
              return TodoCard(
                todoModel: todo,
                isCompleted: false,
              );
            },
          ))
        ],
      ),
    );
  }
}
