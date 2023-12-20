import 'package:flutter/material.dart';
import 'package:offline_report_system/widgets/app_colors.dart';
import 'package:offline_report_system/widgets/app_text.dart';
import 'package:offline_report_system/widgets/const.dart';

class TermsOfService extends StatefulWidget {
  const TermsOfService({super.key});

  @override
  State<TermsOfService> createState() => _TermsOfServiceState();
}

class _TermsOfServiceState extends State<TermsOfService> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const AppText(text: 'Terms Of Service'),
      ),
      body: Container(
        color: AppColors.primaryColor,
        child: Container(
          width: screenSize.width,
          padding: EdgeInsets.all(screenSize.width * 0.03),
          decoration: const BoxDecoration(
            color: AppColors.bgColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(70.0),
            ),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
                const AppText(
                  text: 'SLCB - Offline Report System',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: screenSize.height * 0.02,
                  child: const Divider(
                    thickness: 5.0,
                  ),
                ),
                AppText(
                  text: randomText + randomText + randomText + randomText,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
