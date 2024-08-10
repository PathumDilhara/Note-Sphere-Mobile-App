import 'package:flutter/cupertino.dart';

import '../models/todo_model.dart';

class TodoInheritedWidget extends InheritedWidget {
  final List<TodoModel> todoModel;   // We are listening to this
  final Function(List<TodoModel>) updateTodos;

  const TodoInheritedWidget({
    super.key,
    required super.child,
    required this.todoModel,
    required this.updateTodos,
  });

  static TodoInheritedWidget? of(BuildContext context) {
    // give the latest values of from listened widget
    return context.dependOnInheritedWidgetOfExactType<TodoInheritedWidget>();
  }

  @override
  bool updateShouldNotify(covariant TodoInheritedWidget oldWidget) {
    return  oldWidget.todoModel != todoModel;
  }
}
