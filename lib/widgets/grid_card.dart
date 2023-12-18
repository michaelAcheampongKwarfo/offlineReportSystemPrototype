import 'package:flutter/material.dart';
import 'package:offline_report_system/widgets/app_colors.dart';
import 'package:offline_report_system/widgets/app_text.dart';

class GridCard extends StatelessWidget {
  final String provinceName;
  final String imagePath;
  final VoidCallback onTap;
  const GridCard({
    super.key,
    required this.onTap,
    required this.provinceName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, left: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: AppColors.primaryColor),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(
                  width: double.infinity,
                  color: AppColors.primaryColor,
                  padding: const EdgeInsets.all(10.0),
                  child: AppText(
                    text: provinceName,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(30.0)),
                    child: Image.asset(
                      imagePath,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
