import 'package:f24_notes_sphere/utils/colors.dart';
import 'package:f24_notes_sphere/utils/text_styles.dart';
import 'package:flutter/material.dart';

class NoteCategoryCard extends StatefulWidget {
  final String noteTitle;
  final String noteContent;

  final Future Function() removeNote;
  final Future Function() editNote;
  const NoteCategoryCard({
    super.key,
    required this.noteTitle,
    required this.noteContent,
    required this.removeNote,
    required this.editNote,
  });

  @override
  State<NoteCategoryCard> createState() => _NoteCategoryCardState();
}

class _NoteCategoryCardState extends State<NoteCategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.kCardColor,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: widget.editNote,
                  icon: Icon(
                    Icons.edit_outlined,
                    color: AppColors.kWhiteColor.withOpacity(0.5),
                    size: 25,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: widget.removeNote,
                  icon: Icon(
                    Icons.delete_outlined,
                    color: AppColors.kWhiteColor.withOpacity(0.5),
                    size: 25,
                  ),
                ),
              ],
            ),
            Text(
              widget.noteTitle,
              style: AppTextStyles.appSubTitleStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              widget.noteContent,
              style: AppTextStyles.appDescriptionSmallStyle.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.5),
              ),
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
