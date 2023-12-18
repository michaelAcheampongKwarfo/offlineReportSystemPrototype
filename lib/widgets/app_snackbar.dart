import 'package:flutter/material.dart';
import 'package:offline_report_system/widgets/app_colors.dart';
import 'package:offline_report_system/widgets/app_text.dart';

class AppSnackBar {
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AppText(
          text: message,
          color: AppColors.whiteColor,
        ),
        backgroundColor: AppColors.hintColor,
      ),
    );
  }
}
