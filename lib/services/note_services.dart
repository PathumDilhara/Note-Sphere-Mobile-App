import 'package:uuid/uuid.dart';

import '../models/note_model.dart';

class NoteServices {
  List<NoteModel> allNotes = [
    NoteModel(
      id: const Uuid().v4(),
      title: "Meeting Notes",
      category: "Work",
      content:
          " Insert print statements or logs in the constructor and critical methods to trace the creation and usage of loggers.",
      date: DateTime.now(),
    ),
  ];
}
