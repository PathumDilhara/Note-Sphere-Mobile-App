import 'package:f24_notes_sphere/models/todo_model.dart';
import 'package:f24_notes_sphere/services/todo_services.dart';
import 'package:f24_notes_sphere/utils/colors.dart';
import 'package:f24_notes_sphere/widgets/completed_tab.dart';
import 'package:f24_notes_sphere/widgets/todo_tab.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        onPressed: () {},
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
          ),
          CompletedTab(
            completedTodos: completedTodos,
          )
        ],
      ),
    );
  }
}
