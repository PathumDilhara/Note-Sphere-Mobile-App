import 'package:f24_notes_sphere/helpers/snackbar.dart';
import 'package:f24_notes_sphere/services/todo_services.dart';
import 'package:f24_notes_sphere/utils/router.dart';
import 'package:f24_notes_sphere/utils/text_styles.dart';
import 'package:f24_notes_sphere/widgets/todo_card.dart';
import 'package:flutter/material.dart';

import '../models/todo_model.dart';

class TodoTab extends StatefulWidget {
  final List<TodoModel> inCompletedTodos;
  final List<TodoModel> completedTodos;
  const TodoTab({
    super.key,
    required this.inCompletedTodos,
    required this.completedTodos,
  });

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  // Mark todo as done
  void _markTodoAsDone(TodoModel todoModel) async {
    try {
      final TodoModel updatedTodo = TodoModel(
        title: todoModel.title,
        date: todoModel.date,
        time: todoModel.time,
        isDone: true,
      );

      await TodoServices().markAsDone(updatedTodo);

      // Snack bar
      AppHelpers.showSnackBar(context, "Mark as done");
      setState(() {
        // remove marked one from incompleted todos, & add again to update
        widget.inCompletedTodos.remove(todoModel);
        widget.completedTodos.add(updatedTodo);
      });

    } catch (err) {
      print(err.toString());
      AppHelpers.showSnackBar(context, "Failed to Mark as Done");
    }
  }

  @override
  Widget build(BuildContext context) {
    // sort the todos by time
    setState(() {
      widget.inCompletedTodos.sort((a, b) => a.time.compareTo(b.time));
    });
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
              final TodoModel todoModel = widget.inCompletedTodos[index];
              return TodoCard(
                todoModel: todoModel,
                isCompleted: false,
                onCheckBoxChanged: () => _markTodoAsDone(todoModel),
              );
            },
          ))
        ],
      ),
    );
  }
}
