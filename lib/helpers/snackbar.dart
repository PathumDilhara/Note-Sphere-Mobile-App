import 'package:f24_notes_sphere/utils/colors.dart';
import 'package:f24_notes_sphere/utils/text_styles.dart';
import 'package:flutter/material.dart';

class AppHelpers {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.kFlaButColor,
        content: Text(
          message,
          style: AppTextStyles.appDescriptionLargeStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
