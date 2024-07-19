import 'package:f24_notes_sphere/services/note_services.dart';
import 'package:f24_notes_sphere/utils/router.dart';
import 'package:f24_notes_sphere/utils/text_styles.dart';
import 'package:f24_notes_sphere/widgets/notes_card.dart';
import 'package:flutter/material.dart';

import '../models/note_model.dart';
import '../utils/colors.dart';
import '../widgets/bottom_sheet.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final NoteServices noteServices = NoteServices();
  List<NoteModel> allNotes = [];
  Map<String, List<NoteModel>> notesWithCategory = {};

  @override
  void initState() {
    super.initState();
    _checkAndCreateData();
  }

  // Check whether the user is new
  void _checkAndCreateData() async {
    final bool isNewUser = await noteServices.isNewUser();
    // If the user is new create the initial notes in the db
    if (isNewUser) {
      await noteServices.createInitialNotes();
    }
    // load the notes
    _loadNotes();
  }

  // load the notes
  Future<void> _loadNotes() async {
    final List<NoteModel> loadNotes = await noteServices.loadNotes();
    final Map<String, List<NoteModel>> notesByCategory =
        noteServices.getNotesByCategoryMap(loadNotes);
    setState(() {
      allNotes = loadNotes;
      notesWithCategory = notesByCategory;
      // print(allNotes.length);
      print(notesWithCategory);
    });
  }

  // Open bottom sheet
  void openBottomSheet() {
    showModalBottomSheet(
      barrierColor: Colors.black.withOpacity(0.7),
      context: context,
      builder: (context) {
        return CategoryInputBottomSheet(
          onNewNote: () {
            Navigator.pop(context); // Close the bottom sheet
            AppRouter.router.push("/create_new_note", extra: false);
          },
        onNewCategory: (){
          Navigator.pop(context); // Close the bottom sheet
          AppRouter.router.push("/create_new_note", extra: true);
        },);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            AppRouter.router.go("/");
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Notes", style: AppTextStyles.appTitleStyle),
            const SizedBox(
              height: 30,
            ),
            allNotes.isEmpty ? _emptySizedBox() : _noteGrid(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openBottomSheet,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
          side: BorderSide(
            color: AppColors.kWhiteColor,
            width: 3,
          ),
        ),
        child: const Icon(
          Icons.add,
          size: 30,
          color: AppColors.kWhiteColor,
        ),
      ),
    );
  }

  // If notes are empty
  Widget _emptySizedBox() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: const Center(
        child: Text(
            "No notes are available, please click the + button to add a new note"),
      ),
    );
  }

  // If notes are not empty
  Widget _noteGrid() {
    return GridView.builder(
      itemCount: notesWithCategory.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 6 / 4,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            // go to the notes by category page
            AppRouter.router.push(
              "/category",
              extra: notesWithCategory.keys.elementAt(index),
            );
          },
          child: NotesCard(
            noteCategory: notesWithCategory.keys.elementAt(index),
            noOfNotes: notesWithCategory.values.elementAt(index).length,
          ),
        );
      },
    );
  }
}
