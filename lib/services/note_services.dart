import 'package:hive/hive.dart';
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
    NoteModel(
      id: const Uuid().v4(),
      title: "Grocery List",
      category: "Personal",
      content:
          " Insert print statements or logs in the constructor and critical methods to trace the creation and usage of loggers.",
      date: DateTime.now(),
    ),
    NoteModel(
      id: const Uuid().v4(),
      title: "Book Recommendation",
      category: "Hobby",
      content:
          " Insert print statements or logs in the constructor and critical methods to trace the creation and usage of loggers.",
      date: DateTime.now(),
    ),
  ];

  // Create the database reference for note
  final _myNoteBox = Hive.box("notes");

  // Check whether the user is new user
  Future<bool> isNewUser() async {
    return _myNoteBox.isEmpty;
  }

  // Method to create to initial notes if the NoteBox is empty
  Future<void> createInitialNotes() async {
    if (_myNoteBox.isEmpty) {
      await _myNoteBox.put("notes", allNotes);
    }
  }

  // Method to load the notes
  Future<List<NoteModel>> loadNotes() async {
    final dynamic notes = _myNoteBox.get("notes");

    if (notes != null && notes is List<dynamic>) {
      return notes.cast<NoteModel>().toList();
    }

    return [];
  }

  // Loop through all notes and create an object where the key is the category
  // and the value is the notes in that category
  Map<String, List<NoteModel>> getNotesByCategoryMap(List<NoteModel> allNotes) {
    final Map<String, List<NoteModel>> notesByCategory = {};

    for (final note in allNotes) {
      if (notesByCategory.containsKey(note.category)) {
        notesByCategory[note.category]!.add(note);
      } else {
        notesByCategory[note.category] = [note];
      }
    }
    return notesByCategory;
  }

  // Method to get the notes according to the category
  Future<List<NoteModel>> getNotesByCategoryName(String category) async {
    final dynamic allNotes = await _myNoteBox.get("notes");
    final List<NoteModel> notes = [];

    for (final note in allNotes) {
      if (note.category == category) {
        notes.add(note);
      }
    }
    return notes;
  }

  // Method to edit the notes
  Future<void> updateNotes(NoteModel note) async {
    try {
      final dynamic allNotes = await _myNoteBox.get("notes");
      final int index = allNotes.indexWhere((element) => element.id == note.id);
      allNotes[index] = note;
      await _myNoteBox.put("notes", allNotes);
    } catch (err) {
      print(err);
    }
  }

  // Method to delete a note
  Future<void> deleteNote (String noteId) async {
    try {
      final dynamic allNotes = await _myNoteBox.get("notes");
      allNotes.removeWhere((element) => element.id == noteId);
      await _myNoteBox.put("notes", allNotes);
    } catch (err){
      print(err.toString());
    }
  }

  // Method to get all the categories
  Future <List<String>> getAllCategories() async {
    final List<String> categories = [];
    final dynamic allNotes = await _myNoteBox.get("notes");

    for (final note in allNotes) {
      if (!categories.contains(note.category)) {
        categories.add(note.category);
      }
    }
    return categories;
  }
}
