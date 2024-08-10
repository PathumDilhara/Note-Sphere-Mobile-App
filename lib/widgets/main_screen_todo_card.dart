import 'package:f24_notes_sphere/utils/colors.dart';
import 'package:f24_notes_sphere/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainScreenTodoCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final bool isDone;
  const MainScreenTodoCard({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.kCardColor, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.appDescriptionLargeStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "${DateFormat.yMMMd().format(
                    DateTime.parse(date),
                  )} ${DateFormat.Hm().format(
                    DateTime.parse(time),
                  )}",
                  style: AppTextStyles.appDescriptionSmallStyle.copyWith(
                    color: AppColors.kWhiteColor.withOpacity(0.5),
                  ),
                )
              ],
            ),
          ),
          Icon(
            isDone ? Icons.done_all_outlined : Icons.done_outlined,
            color: isDone ? Colors.greenAccent : Colors.redAccent,
          )
        ],
      ),
    );
  }
}
