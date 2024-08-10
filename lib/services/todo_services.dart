import 'package:f24_notes_sphere/models/todo_model.dart';
import 'package:hive/hive.dart';

class TodoServices {
  // all todos, pre defined todos
  List<TodoModel> todos = [
    TodoModel(
      title: "Read a book",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
    TodoModel(
      title: "Go for a walk",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
    TodoModel(
      title: "Complete assignment",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
  ];

  // create data base reference for todos
  final _myTodoBox = Hive.box("todos");

  // Check whether the user is new user
  Future<bool> isNewUser() async {
    return _myTodoBox.isEmpty;
  }

  // Method to create to initial todos if the todoBox is empty
  Future<void> createInitialTodos() async {
    if (_myTodoBox.isEmpty) {
      await _myTodoBox.put("todos", todos); // todo was created above as a list
    }
  }

  // Method to load the todos
  Future<List<TodoModel>> loadTodos() async {
    final dynamic todos =
        await _myTodoBox.get("todos"); // get data from hive box
    if (todos != null && todos is List<dynamic>) {
      return todos.cast<TodoModel>().toList();
    }
    return [];
  }

  // Mark the todo as done
  Future<void> markAsDone(TodoModel todoModel) async {
    try {
      final dynamic allTodos = await _myTodoBox.get("todos");
      final int index =
          allTodos.indexWhere((element) => element.id == todoModel.id);
      allTodos[index] = todoModel;

      await _myTodoBox.put("todos", allTodos);
    } catch (err) {
      print(err.toString());
    }
  }

  // Add a new todo
  Future<void> addTodo(TodoModel todoModel) async {
    try {
      // get allTodos set from stored todo box
      final dynamic allTodos = await _myTodoBox.get("todos");
      // update the got allTodos set
      allTodos.add(todoModel);
      // Store again allTodos set in todo box using same name(key)
      await _myTodoBox.put("todos", allTodos);
    } catch (err) {
      print(err.toString());
    }
  }
}
