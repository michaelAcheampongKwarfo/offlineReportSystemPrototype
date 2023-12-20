import 'package:flutter/material.dart';
import 'package:offline_report_system/widgets/app_colors.dart';
import 'package:offline_report_system/widgets/app_text.dart';
import 'package:offline_report_system/widgets/const.dart';

class UtilsScreen extends StatelessWidget {
  final String title;
  final String heading;
  final String? subTitle;
  const UtilsScreen(
      {super.key, required this.title, required this.heading, this.subTitle});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: AppText(text: title),
      ),
      body: Container(
        color: AppColors.primaryColor,
        child: Container(
          decoration: const BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.only(topRight: Radius.circular(70.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenSize.height * 0.03,
              ),
              AppText(
                text: heading,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: screenSize.height * 0.03,
                child: const Divider(
                  thickness: 5.0,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(screenSize.width * 0.03),
                  child: AppText(
                    text: subTitle ??
                        randomText + randomText + randomText + randomText,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
