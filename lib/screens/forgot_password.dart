import 'package:flutter/material.dart';
import 'package:offline_report_system/widgets/app_button.dart';
import 'package:offline_report_system/widgets/app_colors.dart';
import 'package:offline_report_system/widgets/app_text.dart';
import 'package:offline_report_system/widgets/app_textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: screenSize.width,
              height: screenSize.height / 2,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenSize.height * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColors.whiteColor,
                        )),
                    SizedBox(
                      width: screenSize.width * 0.3,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.asset(
                        'lib/images/logo.png',
                        width: screenSize.width * 0.1,
                        fit: BoxFit.fill,
                      ),
                    ),
                    // const AppText(
                    //   text: 'SLCB',
                    //   fontSize: 30.0,
                    //   fontWeight: FontWeight.bold,
                    //   color: AppColors.whiteColor,
                    // ),
                  ],
                ),
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppText(
                        text: 'Recover your password',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor,
                      ),
                      SizedBox(
                        height: screenSize.height * 0.03,
                      ),
                      const AppText(
                        text:
                            'Recover password to gain access SLCB offline report system',
                        color: AppColors.whiteColor,
                      ),
                      SizedBox(
                        height: screenSize.height * 0.08,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: screenSize.width * 0.9,
                        padding: EdgeInsets.all(screenSize.width * 0.05),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: AppColors.whiteColor,
                        ),
                        child: Column(
                          children: [
                            AppTextField(
                                width: double.infinity,
                                controller: _emailController,
                                prefixIcon: Icons.email,
                                textInputType: TextInputType.emailAddress,
                                hintText: 'Email'),
                            SizedBox(
                              height: screenSize.height * 0.03,
                            ),
                            AppButton(
                                onTap: () {},
                                child: const AppText(
                                  text: 'Send Link',
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
