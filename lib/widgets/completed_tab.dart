import 'package:f24_notes_sphere/helpers/snackbar.dart';
import 'package:f24_notes_sphere/services/todo_services.dart';
import 'package:f24_notes_sphere/utils/router.dart';
import 'package:f24_notes_sphere/widgets/todo_card.dart';
import 'package:flutter/material.dart';

import '../inherited_widgets/todo_inherited_widget.dart';
import '../models/todo_model.dart';

class CompletedTab extends StatefulWidget {
  final List<TodoModel> completedTodos;
  final List<TodoModel> inCompletedTodos;
  const CompletedTab({
    super.key,
    required this.completedTodos,
    required this.inCompletedTodos,
  });

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  // Mark todo as undone
  void _markTodoAsUnDone(TodoModel todoModel) async {
    try {
      final TodoModel updatedTodo = TodoModel(
        title: todoModel.title,
        date: todoModel.date,
        time: todoModel.time,
        isDone: false,
        id: todoModel.id,
      );

      await TodoServices().markAsDone(updatedTodo);

      // Snack bar
      AppHelpers.showSnackBar(context, "Mark as Undone");
      setState(() {
        // remove marked one from incompleted todos, & add again to update
        widget.completedTodos.remove(todoModel);
        widget.inCompletedTodos.add(updatedTodo);
      });
    } catch (err) {
      print(err.toString());
      AppHelpers.showSnackBar(context, "Failed to Mark as Undone");
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
              itemCount: widget.completedTodos.length,
              itemBuilder: (context, index) {
                final TodoModel todoModel = widget.completedTodos[index];
                return Dismissible(
                  key: Key(todoModel.id.toString()),
                  onDismissed: (direction) {
                    setState(() {
                      widget.completedTodos.removeAt(index);
                      TodoServices().deleteTodo(todoModel);
                    });
                    AppHelpers.showSnackBar(context, "Deleted");
                  },
                  child: TodoCard(
                    todoModel: todoModel,
                    isCompleted: true,
                    onCheckBoxChanged: () => _markTodoAsUnDone(todoModel),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
