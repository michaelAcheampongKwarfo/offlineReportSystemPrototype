import 'package:flutter/material.dart';
import 'package:offline_report_system/widgets/app_colors.dart';
import 'package:offline_report_system/widgets/app_text.dart';

class ContactUsList extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  const ContactUsList({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: screenSize.width * 0.01),
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: AppColors.blackColor, width: 0.5),
        ),
      ),
      child: ListTile(
        title: AppText(
          text: title,
          fontWeight: FontWeight.bold,
        ),
        subtitle: AppText(text: subTitle),
        trailing: Icon(icon),
      ),
    );
  }
}
