import 'package:flutter/material.dart';
import 'package:offline_report_system/screens/branch_datatable.dart';
import 'package:offline_report_system/widgets/app_button.dart';
import 'package:offline_report_system/widgets/app_colors.dart';
import 'package:offline_report_system/widgets/app_text.dart';
import 'package:offline_report_system/widgets/const.dart';

class BranchScreen extends StatelessWidget {
  final String branchName;
  final String branchImage;

  const BranchScreen({
    super.key,
    required this.branchName,
    required this.branchImage,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: AppText(text: branchName),
      ),
      body: Column(
        children: [
          Container(
            width: screenSize.width,
            height: screenSize.height * 0.45,
            decoration: const BoxDecoration(
              color: AppColors.bgColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(70.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.02),
              child: Column(
                children: [
                  const AppText(
                    text: 'Branch Location',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  Image.asset(
                    branchImage,
                    height: screenSize.height * 0.3,
                    width: screenSize.width,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  AppText(
                    text: randomText,
                    fontSize: 14.0,
                    textAlign: TextAlign.center,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: AppColors.bgColor,
              child: Container(
                width: screenSize.width,
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppText(
                      text: 'Note',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    AppText(
                      text: randomText,
                      color: AppColors.blackColor,
                    ),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    AppButton(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BranchDataTable(branchName: branchName),
                            ),
                          );
                        },
                        child: const AppText(
                          text: 'View DataTable',
                          color: AppColors.whiteColor,
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
