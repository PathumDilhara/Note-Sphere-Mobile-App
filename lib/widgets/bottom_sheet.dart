import 'package:f24_notes_sphere/utils/colors.dart';
import 'package:f24_notes_sphere/utils/text_styles.dart';
import 'package:flutter/material.dart';

class CategoryInputBottomSheet extends StatefulWidget {
  final Function() onNewNote;
  final Function() onNewCategory;
  const CategoryInputBottomSheet({
    super.key,
    required this.onNewNote,
    required this.onNewCategory,
  });

  @override
  State<CategoryInputBottomSheet> createState() =>
      _CategoryInputBottomSheetState();
}

class _CategoryInputBottomSheetState extends State<CategoryInputBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: const BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: widget.onNewNote,
              child: GestureDetector(
                onTap: widget.onNewNote,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Create a new note",
                      style: AppTextStyles.appDescriptionLargeStyle,
                    ),
                    const Icon(
                      Icons.arrow_right_outlined,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Divider(
              color: AppColors.kWhiteColor.withOpacity(0.3),
              thickness: 1,
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: widget.onNewCategory,
              child: GestureDetector(
                onTap: widget.onNewCategory,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Create a new note category",
                      style: AppTextStyles.appDescriptionLargeStyle,
                    ),
                    const Icon(
                      Icons.arrow_right_outlined,
                      size: 20,
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
}
