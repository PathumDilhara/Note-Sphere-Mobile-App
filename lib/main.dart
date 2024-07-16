import 'package:f24_notes_sphere/models/note_model.dart';
import 'package:f24_notes_sphere/models/todo_model.dart';
import 'package:f24_notes_sphere/utils/router.dart';
import 'package:f24_notes_sphere/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hive_flutter/adapters.dart';

void main() async {
  // Initialize the Hive package
  await Hive.initFlutter(); // import 'package:hive_flutter/adapters.dart';

  // Register the adapters
  Hive.registerAdapter(NoteModelAdapter());
  Hive.registerAdapter(TodoModelAdapter());

  // Open Hive boxes
  await Hive.openBox("notes");
  await Hive.openBox("todos");
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      theme: ThemeClass.darkTheme.copyWith(
        // Adding google fonts
       textTheme: GoogleFonts.dmSansTextTheme(Theme.of(context).textTheme),
      ),
      title: "Note Sphere",
    );
  }
}

// flutter pub add google_fonts
// flutter pub add go_router
// flutter pub add hive
// flutter pub add hive_flutter
// dart pub add hive_generator
// dart pub add dev:build_runner
// flutter pub add uuid
