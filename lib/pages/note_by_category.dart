import 'package:f24_notes_sphere/services/note_services.dart';
import 'package:f24_notes_sphere/utils/text_styles.dart';
import 'package:flutter/material.dart';

import '../models/note_model.dart';

class NoteByCategory extends StatefulWidget {
  final String category;
  const NoteByCategory({
    super.key,
    required this.category,
  });

  @override
  State<NoteByCategory> createState() => _NoteByCategoryState();
}

class _NoteByCategoryState extends State<NoteByCategory> {
  final NoteServices noteServices = NoteServices();
  List<NoteModel> noteList = [];

  @override
  void initState() {
    super.initState();
    _loadNotesByCategory();
  }

  // Load notes by category
  Future<void> _loadNotesByCategory() async {
    noteList = await noteServices.getNotesByCategoryName(widget.category);
    setState(() {
      print(noteList.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category,
          style: AppTextStyles.appSubTitleStyle
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
