import 'package:f24_notes_sphere/models/note_model.dart';
import 'package:f24_notes_sphere/pages/home_page.dart';
import 'package:f24_notes_sphere/pages/note_by_category_page.dart';
import 'package:f24_notes_sphere/pages/notes_page.dart';
import 'package:f24_notes_sphere/pages/todo_page.dart';
import 'package:f24_notes_sphere/pages/update_note_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/create_new_note_page.dart';

class AppRouter {
  static final router = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    debugLogDiagnostics: false,
    initialLocation: "/",
    routes: [
      // Home page
      GoRoute(
        name: "home",
        path: "/",
        builder: (context, state) => const HomePage(),
      ),
      // Notes page
      GoRoute(
        name: "notes",
        path: "/notes",
        builder: (context, state) => const NotesPage(),
      ),
      // Todo page
      GoRoute(
        name: "todo",
        path: "/todo",
        builder: (context, state) => const TodoPage(),
      ),

      // notes by category
      GoRoute(
        name: "notes category",
        path: "/category",
        builder: (context, state) {
          final String category = state.extra as String;
          return NoteByCategory(category: category);
        },
      ),

      // Create new note page
      GoRoute(
        name: "create_new_note",
        path: "/create_new_note",
        builder: (context, state) {
          final isNewCategory = state.extra as bool;
          return CreateNewNotePage(
            isNewCategory: isNewCategory,
          );
        },
      ),

      // Edit note page
      GoRoute(
        name: "edit note",
        path: "/edit_note",
        builder: (context, state) {
          final NoteModel note = state.extra as NoteModel;
          return UpdateNotePage(noteModel: note);
        },
      ),
    ],
  );
}
