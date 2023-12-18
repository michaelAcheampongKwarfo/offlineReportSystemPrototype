import 'package:flutter/material.dart';
import 'package:offline_report_system/widgets/app_button.dart';
import 'package:offline_report_system/widgets/app_colors.dart';
import 'package:offline_report_system/widgets/app_text.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  'lib/images/logo.png',
                  width: screenSize.width * 0.3,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              // const AppText(
              //   text: 'Sierra Leone Commercial Bank',
              //   color: Colors.white,
              //   fontSize: 20.0,
              //   fontWeight: FontWeight.bold,
              // ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              Container(
                alignment: Alignment.center,
                width: screenSize.width,
                padding: EdgeInsets.all(screenSize.width * 0.05),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    const AppText(
                      text: 'Sierra Leone Commercial Bank',
                      color: AppColors.primaryColor,
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: screenSize.height * 0.01,
                    ),
                    const AppText(
                      text: 'Offline Report System',
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                    // const AppText(
                    //   text: 'Delivering Value',
                    //   color: AppColors.hintColor,
                    //   fontWeight: FontWeight.bold,
                    // ),
                    SizedBox(
                      height: screenSize.height * 0.03,
                    ),
                    AppButton(
                        onTap: () {
                          Navigator.pushNamed(context, '/signInScreen');
                        },
                        child: const AppText(
                          text: 'Sign In',
                          color: AppColors.whiteColor,
                        )),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    AppButton(
                      onTap: () {
                        Navigator.pushNamed(context, '/signUpScreen');
                      },
                      buttonColor: AppColors.whiteColor,
                      borderColor: AppColors.primaryColor,
                      child: const AppText(
                        text: 'Sign Up',
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          text: '----- Or connect using -----',
                          color: AppColors.hintColor,
                          fontSize: 15.0,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppButton(
                            onTap: () {},
                            width: screenSize.width * 0.2,
                            buttonColor: AppColors.blueColor,
                            child: const Icon(
                              Icons.facebook,
                              color: AppColors.whiteColor,
                            )),
                        SizedBox(
                          width: screenSize.width * 0.03,
                        ),
                        AppButton(
                            onTap: () {},
                            width: screenSize.width * 0.2,
                            buttonColor: AppColors.redColor,
                            child: const Icon(
                              Icons.email,
                              color: AppColors.whiteColor,
                            )),
                        SizedBox(
                          width: screenSize.width * 0.03,
                        ),
                        AppButton(
                            onTap: () {},
                            width: screenSize.width * 0.2,
                            buttonColor: AppColors.hintColor,
                            child: const Icon(
                              Icons.phone_android,
                              color: AppColors.whiteColor,
                            )),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}
