// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:offline_report_system/services/firebase_services.dart';
import 'package:offline_report_system/widgets/app_button.dart';
import 'package:offline_report_system/widgets/app_colors.dart';
import 'package:offline_report_system/widgets/app_snackbar.dart';
import 'package:offline_report_system/widgets/app_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const AppText(
          text: 'Profile',
          fontSize: 20.0,
        ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              color: AppColors.primaryColor,
              child: Container(
                width: screenSize.width,
                height: screenSize.height * 0.2,
                padding: EdgeInsets.all(screenSize.width * 0.02),
                decoration: const BoxDecoration(
                  color: AppColors.bgColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(70.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      child: Icon(
                        Icons.person,
                        size: 50.0,
                        color: AppColors.hintColor,
                      ),
                    ),
                    AppText(
                      text: FirebaseAuth.instance.currentUser!.email ??
                          'User Name',
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: AppColors.bgColor,
              child: Container(
                width: screenSize.width,
                padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.03,
                    vertical: screenSize.height * 0.03),
                decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AppText(
                      text: 'SLCB - Offline Report System',
                      color: AppColors.hintColor,
                    ),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    Column(
                      children: [
                        AppButton(
                          onTap: () {},
                          width: screenSize.width * 0.2,
                          borderColor: AppColors.primaryColor,
                          buttonColor: AppColors.whiteColor,
                          child: const Icon(Icons.star_outline),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.01,
                        ),
                        const AppText(text: 'Send\nFeedback'),
                      ],
                    ),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    const AppText(
                      text: 'SLCB - Help and Support',
                      color: AppColors.hintColor,
                    ),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            AppButton(
                              onTap: () {},
                              width: screenSize.width * 0.2,
                              borderColor: AppColors.primaryColor,
                              buttonColor: AppColors.whiteColor,
                              child: const Icon(Icons.phone_callback),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.01,
                            ),
                            const AppText(text: 'Contact\nUs')
                          ],
                        ),
                        SizedBox(
                          width: screenSize.width * 0.04,
                        ),
                        Column(
                          children: [
                            AppButton(
                              onTap: () {},
                              width: screenSize.width * 0.2,
                              borderColor: AppColors.primaryColor,
                              buttonColor: AppColors.whiteColor,
                              child: const Icon(Icons.report_outlined),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.01,
                            ),
                            const AppText(text: 'Report\nIssue')
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    const AppText(
                      text: 'SLCB - Legal',
                      color: AppColors.hintColor,
                    ),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            AppButton(
                              onTap: () {},
                              width: screenSize.width * 0.2,
                              borderColor: AppColors.primaryColor,
                              buttonColor: AppColors.whiteColor,
                              child: const Icon(
                                Icons.gavel_outlined,
                              ),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.01,
                            ),
                            const AppText(text: 'Legal\nPolicy')
                          ],
                        ),
                        SizedBox(
                          width: screenSize.width * 0.04,
                        ),
                        Column(
                          children: [
                            AppButton(
                              onTap: () {},
                              width: screenSize.width * 0.2,
                              borderColor: AppColors.primaryColor,
                              buttonColor: AppColors.whiteColor,
                              child: const Icon(Icons.groups_3_outlined),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.01,
                            ),
                            const AppText(text: 'Community\nStandard')
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          const AppText(text: 'APP VERSION 1.0.0'),
                          AppButton(
                            onTap: () {
                              Navigator.pushNamed(context, '/welcomeScreen');
                            },
                            width: screenSize.width * 0.5,
                            borderColor: AppColors.primaryColor,
                            buttonColor: AppColors.whiteColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const AppText(text: 'LOGOUT'),
                                SizedBox(
                                  width: screenSize.width * 0.03,
                                ),
                                const Icon(Icons.logout_outlined),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void userSignOut() async {
    try {
      await _firebaseService.userSignOut(context);
      Navigator.pushReplacementNamed(context, '/welcomeScreen');
    } catch (e) {
      AppSnackBar().showSnackBar(context, 'An error occurred: $e');
    }
  }
}
