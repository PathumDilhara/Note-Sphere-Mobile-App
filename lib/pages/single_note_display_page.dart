import 'package:f24_notes_sphere/models/note_model.dart';
import 'package:f24_notes_sphere/utils/colors.dart';
import 'package:f24_notes_sphere/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SingleNoteDisplayPage extends StatefulWidget {
  final NoteModel noteModel;
  const SingleNoteDisplayPage({super.key, required this.noteModel});

  @override
  State<SingleNoteDisplayPage> createState() => _SingleNoteDisplayPageState();
}

class _SingleNoteDisplayPageState extends State<SingleNoteDisplayPage> {
  @override
  Widget build(BuildContext context) {
    // Formatted date
    final formattedDate = DateFormat.yMMMd().format(widget.noteModel.date);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Note",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.noteModel.title,
              style: AppTextStyles.appTitleStyle,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.noteModel.category,
              style: AppTextStyles.appButton.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.3),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              formattedDate,
              style: AppTextStyles.appDescriptionSmallStyle.copyWith(
                color: AppColors.kFlaButColor,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.noteModel.content,
              style: AppTextStyles.appDescriptionLargeStyle
                  .copyWith(color: AppColors.kWhiteColor.withOpacity(0.3)),
            ),
          ],
        ),
      ),
    );
  }
}
