import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:offline_report_system/widgets/app_colors.dart';
import 'package:offline_report_system/widgets/app_text.dart';
import 'package:offline_report_system/widgets/const.dart';
import 'package:offline_report_system/widgets/contact_us_list.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    List contactIcons = [
      Icons.phone_outlined,
      Icons.phone_android_outlined,
      Icons.chat_bubble_outline,
      Icons.email_outlined,
      Icons.facebook_outlined,
      Icons.phone_outlined,
    ];

    return Scaffold(
      appBar: AppBar(title: const AppText(text: 'Contact us')),
      body: Container(
        color: AppColors.primaryColor,
        child: Container(
          width: screenSize.width,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(70.0)),
              color: AppColors.bgColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenSize.height * 0.15,
                child: const Center(
                  child: AppText(
                    text:
                        'Our customer care representative are available 24 hours to attend to all your service needs .',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: screenSize.width,
                  padding: EdgeInsets.all(screenSize.width * 0.03),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    color: AppColors.whiteColor,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: contactMap.length,
                    itemBuilder: (context, index) {
                      return ContactUsList(
                        title: contactMap.keys.elementAt(index),
                        subTitle: contactMap.values.elementAt(index),
                        icon: contactIcons[index],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
