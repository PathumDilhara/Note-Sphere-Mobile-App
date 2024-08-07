import 'package:f24_notes_sphere/helpers/snackbar.dart';
import 'package:f24_notes_sphere/models/note_model.dart';
import 'package:f24_notes_sphere/services/note_services.dart';
import 'package:f24_notes_sphere/utils/colors.dart';
import 'package:f24_notes_sphere/utils/router.dart';
import 'package:f24_notes_sphere/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class UpdateNotePage extends StatefulWidget {
  final NoteModel noteModel;
  const UpdateNotePage({
    super.key,
    required this.noteModel,
  });

  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  List<String> categories = [];
  final NoteServices noteServices = NoteServices();

  // Form validation
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteContentController = TextEditingController();
  String category = "";

  // Dispose the above created text editing controllers
  //Memory Management: Disposing of objects like TextEditingController ensures
  // that the memory allocated for them is released. This is crucial in mobile
  // development where memory resources are limited.
  @override
  void dispose() {
    super.dispose();
    _noteTitleController.dispose();
    _noteContentController.dispose();
  }

  Future _loadCategories() async {
    categories = await noteServices.getAllCategories();
    setState(() {
      //print(categories.length); // 3
    });
  }

  @override
  void initState() {
    _noteTitleController.text = widget.noteModel.title;
    _noteContentController.text = widget.noteModel.content;
    category = widget.noteModel.category;
    // Cant be async hence use separate Future method
    _loadCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Note",
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
                key: _formKey,
                child: Column(
                  children: [
                    // drop down
                    _newNote(),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _noteTitleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a title";
                        }
                        return null;
                      },
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
                      controller: _noteContentController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your content";
                        }
                        return null;
                      },
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
                          onPressed: () {
                            // Update note
                            if (_formKey.currentState!.validate()) {
                              try {
                                noteServices.updateNotes(
                                  NoteModel(
                                    title: _noteTitleController.text,
                                    category: category,
                                    content: _noteContentController.text,
                                    date: DateTime.now(),
                                    id: widget.noteModel.id,
                                  ),
                                );
                                
                                // Snack bar
                                AppHelpers.showSnackBar(context, "Note updated successfully");
                                _noteTitleController.clear();
                                _noteContentController.clear();

                                // Navigate to the note page
                                AppRouter.router.push("/notes");
                              } catch (error) {
                                AppHelpers.showSnackBar(context, "Failed to update notes");
                                print(error.toString());
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Update Note",
                              style: AppTextStyles.appButton,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
      child: DropdownButtonFormField<String>(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please select a category";
          }
          return null;
        },
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
        onChanged: (String? value) {
          setState(() {
            category = value!;
          });
        },
      ),
    );
  }
}
