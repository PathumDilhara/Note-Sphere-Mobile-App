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
      print(noteList.length);
    });
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
                      noteTitle: noteList[index].title,
                      noteContent: noteList[index].content,
                      removeNote: ()async {},
                      editNote: ()async{});
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
