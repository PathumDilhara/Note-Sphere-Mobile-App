import 'package:f24_notes_sphere/helpers/snackbar.dart';
import 'package:f24_notes_sphere/services/note_services.dart';
import 'package:f24_notes_sphere/utils/colors.dart';
import 'package:f24_notes_sphere/utils/router.dart';
import 'package:f24_notes_sphere/utils/text_styles.dart';
import 'package:f24_notes_sphere/widgets/note_category_card.dart';
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
      //print(noteList.length);
    });
  }

  // Edit note
  void _editNote(NoteModel noteModel) {
    // Navigator to the edit note page
    AppRouter.router.push("/edit_note", extra: noteModel);
  }

  // remove notes
  Future<void> _removeNote(String id) async {
    try {
      await noteServices.deleteNote(id);
      if (context.mounted) {
        AppHelpers.showSnackBar(context, "Note deleted successfully");
      }
    } catch (error) {
      AppHelpers.showSnackBar(context, "Failed to delete Note");
      //print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            // go to notes page
            AppRouter.router.push("/notes");
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
            color: AppColors.kWhiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.category,
                style: AppTextStyles.appTitleStyle
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              GridView.builder(
                itemCount: noteList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 7 / 11,
                ),
                itemBuilder: (context, index) {
                  return NoteCategoryCard(
                    // Don't wrap entire widget bcs then we cant touch edit delete buttons
                    noteTitle: noteList[index].title,
                    noteContent: noteList[index].content,
                    removeNote: () async {
                      await _removeNote(noteList[index].id);
                      setState(() {
                        noteList.removeAt(index);
                      });
                    },
                    editNote: () async {
                      _editNote(noteList[index]);
                    },
                    viewSingleNote: () {
                      AppRouter.router.push(
                        "/single_note_display",
                        extra: noteList[index],
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
