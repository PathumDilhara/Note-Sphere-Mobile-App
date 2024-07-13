import 'package:f24_notes_sphere/utils/colors.dart';
import 'package:f24_notes_sphere/utils/text_styles.dart';
import 'package:flutter/material.dart';

class NotesTodoCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  const NotesTodoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  State<NotesTodoCard> createState() => _NotesTodoCardState();
}

class _NotesTodoCardState extends State<NotesTodoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.kCardColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15.0,
        ),
        child: Column(
          children: [
            Icon(
              widget.icon,
              size: 40,
            ),
            const SizedBox(height: 10,),
            Text(
              widget.title,
              style: AppTextStyles.appSubTitleStyle,
            ),
            Text(
              widget.description,
              style: AppTextStyles.appDescriptionSmallStyle.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
