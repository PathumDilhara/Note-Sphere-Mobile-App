import 'package:f24_notes_sphere/models/todo_model.dart';
import 'package:f24_notes_sphere/services/note_services.dart';
import 'package:f24_notes_sphere/services/todo_services.dart';
import 'package:f24_notes_sphere/utils/constants.dart';
import 'package:f24_notes_sphere/utils/router.dart';
import 'package:f24_notes_sphere/utils/text_styles.dart';
import 'package:f24_notes_sphere/widgets/main_screen_todo_card.dart';
import 'package:f24_notes_sphere/widgets/notes_todo_card.dart';
import 'package:flutter/material.dart';

import '../models/note_model.dart';
import '../widgets/progress_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Lists to store all initial notes & todos
  List<NoteModel> allNotes = [];
  List<TodoModel> allTodos = [];

  @override
  void initState() {
    super.initState();
    _checkIfUserIsNew();
    setState(() {});
  }

  // Method to check is user new
  void _checkIfUserIsNew() async {
    final bool isNewUser =
        await NoteServices().isNewUser() || await TodoServices().isNewUser();
    if (isNewUser) {
      await NoteServices().createInitialNotes();
      await TodoServices().createInitialTodos();
    }
    _loadTodos();
    _loadNotes();
  }

  // Method to load the notes
  Future<void> _loadNotes() async {
    final List<NoteModel> loadedNotes = await NoteServices().loadNotes();
    setState(() {
      allNotes = loadedNotes;
    });
  }

  // Method to load the todos
  Future<void> _loadTodos() async {
    final List<TodoModel> loadedTodos = await TodoServices().loadTodos();
    setState(() {
      allTodos = loadedTodos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NoteSphere",
          style: AppTextStyles.appTitleStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: kDefaultFontSize,
            ),
            ProgressCard(
              noOfCompletedTasks: allTodos.where((todo) => todo.isDone).length,
              noOfTotalTasks: allTodos.length,
            ),
            SizedBox(
              height: AppConstants.kDefaultPadding * 1.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    AppRouter.router.push("/notes");
                  },
                  child: NotesTodoCard(
                    icon: Icons.bookmark_add_outlined,
                    title: "Notes",
                    description: "${allNotes.length.toString()} Notes",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    AppRouter.router.push("/todo");
                  },
                  child: NotesTodoCard(
                    icon: Icons.bookmark_add_outlined,
                    title: "To-Do List",
                    description: "${allTodos.length.toString()} Tasks",
                  ),
                ),
              ],
            ),
            SizedBox(
              height: AppConstants.kDefaultPadding * 1.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's Progress",
                  style: AppTextStyles.appSubTitleStyle,
                ),
                Text(
                  "See All",
                  style: AppTextStyles.appButton,
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            allTodos.isEmpty
                ? Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.10),
                    child: Column(
                      children: [
                        Text(
                          "No task for today, add some tasks to get started!",
                          style: AppTextStyles.appDescriptionLargeStyle
                              .copyWith(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.blue)),
                          onPressed: () {
                            AppRouter.router.push("/todo");
                          },
                          child: Text(
                            "Add task",
                            style: AppTextStyles.appButton,
                          ),
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: allTodos.length,
                      itemBuilder: (context, index) {
                        final TodoModel todoModel = allTodos[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: MainScreenTodoCard(
                            title: todoModel.title,
                            date: todoModel.date.toString(),
                            time: todoModel.time.toString(),
                            isDone: todoModel.isDone,
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
