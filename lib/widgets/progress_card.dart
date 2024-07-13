import 'package:f24_notes_sphere/utils/colors.dart';
import 'package:f24_notes_sphere/utils/constants.dart';
import 'package:f24_notes_sphere/utils/text_styles.dart';
import 'package:flutter/material.dart';

class ProgressCard extends StatefulWidget {
  final int noOfCompletedTasks;
  final int noOfTotalTasks;
  const ProgressCard({
    super.key,
    required this.noOfCompletedTasks,
    required this.noOfTotalTasks,
  });

  @override
  State<ProgressCard> createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  @override
  Widget build(BuildContext context) {
    // Calculate completion percentage
    double completionPercentage = widget.noOfCompletedTasks != 0
        ? (widget.noOfCompletedTasks / widget.noOfTotalTasks) * 100
        : 0;
    return Container(
      padding: EdgeInsets.all(AppConstants.kDefaultPadding),
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today's progress",
                style: AppTextStyles.appSubTitleStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                // To add constant size as screen size
                width: MediaQuery.of(context).size.width * 0.65,
                child: Text(
                  "You have completed ${widget.noOfCompletedTasks} out of ${widget.noOfTotalTasks} tasks, "
                  "\nkeep up the progress !",
                  style: AppTextStyles.appDescriptionSmallStyle.copyWith(
                    color: AppColors.kWhiteColor.withOpacity(0.5),
                  ),
                ),
              )
            ],
          ),
          // we can do this using Center widget as child of container
          Stack(
            children: [
              Container(
                // use same for a circle
                width: MediaQuery.of(context).size.width * 0.19,
                height: MediaQuery.of(context).size.width * 0.19,
                decoration: BoxDecoration(
                  gradient: AppColors.kPrimaryGradient,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              Positioned.fill(
                  child: Center(
                child: Text(
                  "$completionPercentage%",
                  style: AppTextStyles.appSubTitleStyle.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}
