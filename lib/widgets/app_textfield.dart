import 'package:flutter/material.dart';
import 'package:offline_report_system/widgets/app_colors.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final double width;
  final IconData? prefixIcon;
  final VoidCallback? onTap;
  final bool? obscureText;
  final TextInputType? textInputType;

  const AppTextField({
    super.key,
    required this.width,
    required this.controller,
    required this.hintText,
    this.onTap,
    this.obscureText,
    this.textInputType,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    bool isObscure = obscureText ??
        false; // Set a default value if obscureText is not provided

    return SizedBox(
      width: width,
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        keyboardType: textInputType,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          fontFamily: 'Times New Roman',
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: AppColors.whiteColor),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            fontFamily: 'Times New Roman',
          ),
          fillColor: AppColors.whiteColor,
          filled: true,
          prefixIcon: Icon(
            prefixIcon,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
