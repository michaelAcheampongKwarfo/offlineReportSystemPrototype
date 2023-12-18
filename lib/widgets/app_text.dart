import 'package:flutter/material.dart';
import 'package:offline_report_system/widgets/app_colors.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  const AppText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.textOverflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? AppColors.blackColor,
        fontSize: fontSize ?? 16.0,
        fontWeight: fontWeight ?? FontWeight.w500,
        fontFamily: 'Times New Roman',
      ),
      textAlign: textAlign,
      overflow: textOverflow,
    );
  }
}
