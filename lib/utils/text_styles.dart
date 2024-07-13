import 'package:f24_notes_sphere/utils/colors.dart';
import 'package:flutter/material.dart';

  class AppTextStyles {
    // Title style
    static TextStyle appTitleStyle = const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: AppColors.kWhiteColor,
    );

    // Sub title Style
    static TextStyle appSubTitleStyle = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: AppColors.kWhiteColor,
    );

    // Description large style
    static TextStyle appDescriptionLargeStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: AppColors.kWhiteColor,
    );

    // Description small style
    static TextStyle appDescriptionSmallStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.kWhiteColor,
    );

    // App body style
    static TextStyle appBody = const TextStyle(
      color: AppColors.kWhiteColor,
      fontSize: 16,
    );

    // App button
    static TextStyle appButton = const TextStyle(
      color: AppColors.kWhiteColor,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
  }
