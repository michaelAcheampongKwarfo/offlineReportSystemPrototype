import 'package:flutter/material.dart';
import 'package:offline_report_system/widgets/app_colors.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final double? width;
  final Color? buttonColor;
  final Color? borderColor;

  const AppButton(
      {super.key,
      required this.onTap,
      required this.child,
      this.width,
      this.buttonColor,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: buttonColor ?? AppColors.primaryColor,
          border: Border.all(
            color: borderColor ?? AppColors.transparentColor,
          ),
        ),
        child: Center(child: child),
      ),
    );
  }
}
