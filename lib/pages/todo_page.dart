import 'package:f24_notes_sphere/helpers/snackbar.dart';
import 'package:f24_notes_sphere/models/todo_model.dart';
import 'package:f24_notes_sphere/services/todo_services.dart';
import 'package:f24_notes_sphere/utils/colors.dart';
import 'package:f24_notes_sphere/widgets/completed_tab.dart';
import 'package:f24_notes_sphere/widgets/todo_tab.dart';
import 'package:flutter/material.dart';

import '../inherited_widgets/todo_inherited_widget.dart';
import '../utils/text_styles.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

// to activate tab bar use "with SingleTickerProviderStateMixin"
class _TodoPageState extends State<TodoPage>
    with SingleTickerProviderStateMixin {
  // tab bar controller for store the which tab i in (knowledge)
  late TabController _tabController;

  // variables/states for store todos lists
  late List<TodoModel> allTodos = [];
  late List<TodoModel> incompletedTodos = [];
  late List<TodoModel> completedTodos = [];

  //o Obj for user services class
  TodoServices todoServices = TodoServices();

  // Controller for message model Text field
  final TextEditingController _taskController = TextEditingController();

  @override
  void dispose() {
    _tabController.dispose();
    _taskController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this); // length = no of tabs
    _checkIfUserIsNew();
  }

  // Check is user new or not
  void _checkIfUserIsNew() async {
    final bool isNewUser =
        await todoServices.isNewUser(); // Check in user services
    // print(isNewUser);

    if (isNewUser) {
      await todoServices.createInitialTodos();
    }
    await _loadTodos();
  }

  // Load the todos
  Future<void> _loadTodos() async {
    final List<TodoModel> loadedTodos = await todoServices.loadTodos();
    setState(() {
      allTodos = loadedTodos;
      // incompleted todos
      incompletedTodos = allTodos
          .where((todo) => !todo.isDone)
          .toList(); // work as a loop 'todo' is a variable like 'i, j'

      // Completed todos
      completedTodos = allTodos.where((todo) => todo.isDone).toList();
    });
  }

  // Open message model
  void openMessageModel(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.kCardColor,
          contentPadding: EdgeInsets.zero,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Text(
                  "Add task",
                  style: AppTextStyles.appDescriptionLargeStyle
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: TextField(
              controller: _taskController,
              style: const TextStyle(
                color: AppColors.kWhiteColor,
                fontSize: 20,
              ),
              decoration: InputDecoration(
                hintText: "Enter your task",
                hintStyle: AppTextStyles.appDescriptionSmallStyle.copyWith(
                  color: AppColors.kWhiteColor.withOpacity(0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _addTask();
                _taskController.clear();
              },
              style: ButtonStyle(
                backgroundColor:
                    const WidgetStatePropertyAll(AppColors.kFlaButColor),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              child: Text(
                "Add task",
                style: AppTextStyles.appButton,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _taskController.clear();
              },
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  AppColors.kCardColor,
                ),
              ),
              child: Text(
                "Cancel",
                style: AppTextStyles.appButton,
              ),
            )
          ],
        );
      },
    );
  }

  // Method to add task
  void _addTask() async {
    if (_taskController.text.isNotEmpty) {
      // we don't need pass an id bcs by Uuid automatically add an id
      final TodoModel newTodo = TodoModel(
        title: _taskController.text,
        date: DateTime.now(),
        time: DateTime.now(),
        isDone: false,
      );

      try {
        await todoServices.addTodo(newTodo);
        _loadTodos();
        if(TodoInheritedWidget != null){
          TodoInheritedWidget.of(context)!.updateTodos(allTodos);
        }
        // setState(() {
        //   allTodos.add(newTodo);
        //   incompletedTodos.add(newTodo);
        // });

        AppHelpers.showSnackBar(context, "Task added !");
        Navigator.pop(context); // close the popup window

      } catch (err) {
        AppHelpers.showSnackBar(context, "Failed to add task");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TodoInheritedWidget(
      todoModel: allTodos,
      updateTodos: (p0) {},
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                child: Text(
                  "ToDo",
                  style: AppTextStyles.appDescriptionLargeStyle
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  "Completed",
                  style: AppTextStyles.appDescriptionLargeStyle
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            openMessageModel(context);
          },
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
            side: BorderSide(color: AppColors.kWhiteColor, width: 2),
          ),
          child: const Icon(
            Icons.add,
            size: 30,
            color: AppColors.kWhiteColor,
          ),
        ),
        body: TabBarView(
          controller: _tabController, // For identifying tab switching
          children: [
            // show in order
            TodoTab(
              inCompletedTodos: incompletedTodos,
              completedTodos: completedTodos,
            ),
            CompletedTab(
              completedTodos: completedTodos,
              inCompletedTodos: incompletedTodos,
            )
          ],
        ),
      ),
    );
  }
}
