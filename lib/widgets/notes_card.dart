import 'package:f24_notes_sphere/utils/colors.dart';
import 'package:f24_notes_sphere/utils/constants.dart';
import 'package:f24_notes_sphere/utils/text_styles.dart';
import 'package:flutter/material.dart';

class NotesCard extends StatelessWidget {
  final String noteCategory;
  final int noOfNotes;
  const NotesCard({
    super.key,
    required this.noteCategory,
    required this.noOfNotes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        AppConstants.kDefaultPadding,
      ),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(noteCategory,
          style: AppTextStyles.appSubTitleStyle.copyWith(
            fontWeight: FontWeight.bold,
          ),),
          Text("$noOfNotes notes",
            style: AppTextStyles.appSubTitleStyle.copyWith(
              color: AppColors.kWhiteColor.withOpacity(0.5),
              fontSize: 20
            ),),
        ],
      ),
    );
  }
}
