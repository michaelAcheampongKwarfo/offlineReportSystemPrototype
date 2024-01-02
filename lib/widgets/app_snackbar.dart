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

  // void showBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Container(
  //           padding: EdgeInsets.symmetric(
  //               horizontal: MediaQuery.of(context).size.width * 0.03,
  //               vertical: MediaQuery.of(context).size.height * 0.05),
  //           child: SingleChildScrollView(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: [
  //                 // Dropdown for Branch
  //                 DropdownButtonFormField(items: [items], onChanged: (val){
  //                   setSta
  //                 })
  //                 // Dropdown for fileType

  //                 // Dropdown for display order
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  //}
}
