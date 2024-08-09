import 'package:f24_notes_sphere/utils/colors.dart';
import 'package:f24_notes_sphere/utils/text_styles.dart';
import 'package:flutter/material.dart';

import '../models/todo_model.dart';

class TodoCard extends StatefulWidget {
  final TodoModel todoModel;
  final bool isCompleted;
  const TodoCard({
    super.key,
    required this.todoModel,
    required this.isCompleted,
  });

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          widget.todoModel.title,
          style: AppTextStyles.appDescriptionLargeStyle,
        ),
        subtitle: Row(
          children: [
            Text(
              "${widget.todoModel.date.day}/${widget.todoModel.date.month}/${widget.todoModel.date.year}",
              style: AppTextStyles.appDescriptionSmallStyle.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.5),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "${widget.todoModel.time.hour}:${widget.todoModel.time.minute}",
              style: AppTextStyles.appDescriptionSmallStyle.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.5),
              ),
            ),
          ],
        ),
        trailing: Checkbox(
          value: widget.isCompleted,
          onChanged: (value) {},
        ),
      ),
    );
  }
}
