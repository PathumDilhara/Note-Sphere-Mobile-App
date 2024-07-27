import 'package:f24_notes_sphere/services/note_services.dart';
import 'package:f24_notes_sphere/utils/colors.dart';
import 'package:f24_notes_sphere/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateNewNotePage extends StatefulWidget {
  final bool
      isNewCategory; // For "Create a new note" & "Create a new note category"
  const CreateNewNotePage({
    super.key,
    required this.isNewCategory,
  });

  @override
  State<CreateNewNotePage> createState() => _CreateNewNotePageState();
}

class _CreateNewNotePageState extends State<CreateNewNotePage> {
  List<String> categories = [];
  final NoteServices noteServices = NoteServices();

  Future _loadCategories() async {
    categories = await noteServices.getAllCategories();
    setState(() {
      //print(categories.length); // 3
    });
  }

  @override
  void initState() {
    // Cant be async hence use separate Future method
    _loadCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Note",
          style: AppTextStyles.appSubTitleStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Form(
                child: Column(
                  children: [
                    // drop down
                    widget.isNewCategory ? _newNoteCategory() : _newNote(),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLines: 2,
                      style: const TextStyle(
                        color: AppColors.kWhiteColor,
                        fontSize: 30,
                      ),
                      decoration: InputDecoration(
                        hintText: "Note Title",
                        hintStyle: TextStyle(
                          color: AppColors.kWhiteColor.withOpacity(0.5),
                          fontSize: 35,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Content
                    TextFormField(
                      maxLines: 18,
                      style: const TextStyle(
                        color: AppColors.kWhiteColor,
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        hintText: "Note Content",
                        hintStyle: TextStyle(
                          color: AppColors.kWhiteColor.withOpacity(0.5),
                          fontSize: 20,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: AppColors.kWhiteColor.withOpacity(0.2),
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  AppColors.kFlaButColor)),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Save Note",
                              style: AppTextStyles.appButton,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _newNote() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonFormField(
        style: TextStyle(
          color: AppColors.kWhiteColor,
          fontFamily: GoogleFonts.dmSans().fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        isExpanded: false,
        hint: const Text("Category"),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: AppColors.kWhiteColor.withOpacity(0.1),
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide:
                  const BorderSide(color: AppColors.kWhiteColor, width: 1)),
        ),
        items: categories.map((String category) {
          return DropdownMenuItem<String>(
            alignment: Alignment.centerLeft,
            value: category,
            child: Text(
              category,
              style: AppTextStyles.appButton,
            ),
          );
        }).toList(), // must return a list
        onChanged: (value) {},
      ),
    );
  }

  Widget _newNoteCategory() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        style: const TextStyle(
          color: AppColors.kWhiteColor,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: "New category",
          hintStyle: TextStyle(
            color: AppColors.kWhiteColor.withOpacity(0.5),
            fontWeight: FontWeight.w500,
            fontSize: 20,
            fontFamily: GoogleFonts.dmSans().fontFamily,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: AppColors.kWhiteColor.withOpacity(0.1),
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: AppColors.kWhiteColor,
              width: 2,
            )
          )
        ),
      ),
    );
  }
}
