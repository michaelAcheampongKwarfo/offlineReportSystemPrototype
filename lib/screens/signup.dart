import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:offline_report_system/services/firebase_services.dart';
import 'package:offline_report_system/widgets/app_button.dart';
import 'package:offline_report_system/widgets/app_colors.dart';
import 'package:offline_report_system/widgets/app_snackbar.dart';
import 'package:offline_report_system/widgets/app_text.dart';
import 'package:offline_report_system/widgets/app_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final FirebaseServices _firebaseServices = FirebaseServices();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    // Listen for changes in the user authentication state
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null && user.emailVerified) {
        // If the user is authenticated and their email is verified,
        // navigate to the home screen
        Navigator.pushReplacementNamed(context, '/homeScreen');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                  ],
                ),
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppText(
                        text: 'Sign Up',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor,
                      ),
                      SizedBox(
                        height: screenSize.height * 0.03,
                      ),
                      const AppText(
                        text: 'Sign Up to SLCB offline report system',
                        color: AppColors.whiteColor,
                      ),
                      SizedBox(
                        height: screenSize.height * 0.03,
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
                                controller: _fullNameController,
                                prefixIcon: Icons.person,
                                hintText: 'Full Name'),
                            SizedBox(
                              height: screenSize.height * 0.02,
                            ),
                            AppTextField(
                                width: double.infinity,
                                controller: _emailController,
                                prefixIcon: Icons.email,
                                textInputType: TextInputType.emailAddress,
                                hintText: 'Email'),
                            SizedBox(
                              height: screenSize.height * 0.02,
                            ),
                            AppTextField(
                                width: double.infinity,
                                controller: _passwordController,
                                prefixIcon: Icons.lock,
                                obscureText: true,
                                hintText: 'Password'),
                            SizedBox(
                              height: screenSize.height * 0.02,
                            ),
                            _isLoading
                                ? const CircularProgressIndicator()
                                : AppButton(
                                    onTap: () {
                                      userSignUpMethod();
                                    },
                                    child: const AppText(
                                      text: 'Sign Up',
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.bold,
                                    )),
                            SizedBox(
                              height: screenSize.height * 0.01,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/termsOfService');
                                },
                                child: const AppText(
                                  text: 'Terms of Service',
                                  color: AppColors.primaryColor,
                                  fontSize: 15.0,
                                  textAlign: TextAlign.center,
                                  textOverflow: TextOverflow.ellipsis,
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.02,
                      ),
                      // const Align(
                      //   alignment: Alignment.center,
                      //   child: AppText(
                      //     text: '----- Or connect using -----',
                      //     color: AppColors.hintColor,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: screenSize.height * 0.02,
                      // ),
                      // Container(
                      //     width: screenSize.width,
                      //     padding: EdgeInsets.all(screenSize.width * 0.03),
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(12.0),
                      //       color: AppColors.whiteColor,
                      //     ),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         AppButton(
                      //             onTap: () {},
                      //             width: screenSize.width * 0.2,
                      //             buttonColor: AppColors.blueColor,
                      //             child: const Icon(
                      //               Icons.facebook,
                      //               color: AppColors.whiteColor,
                      //             )),
                      //         SizedBox(
                      //           width: screenSize.width * 0.03,
                      //         ),
                      //         AppButton(
                      //             onTap: () {},
                      //             width: screenSize.width * 0.2,
                      //             buttonColor: AppColors.redColor,
                      //             child: const Icon(
                      //               Icons.email,
                      //               color: AppColors.whiteColor,
                      //             )),
                      //         SizedBox(
                      //           width: screenSize.width * 0.03,
                      //         ),
                      //         AppButton(
                      //             onTap: () {},
                      //             width: screenSize.width * 0.2,
                      //             buttonColor: AppColors.hintColor,
                      //             child: const Icon(
                      //               Icons.phone_android,
                      //               color: AppColors.whiteColor,
                      //             )),
                      //       ],
                      //     ))
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

  void userSignUpMethod() async {
    try {
      if (_fullNameController.text.isEmpty ||
          _emailController.text.isEmpty ||
          _passwordController.text.isEmpty) {
        AppSnackBar().showSnackBar(context, 'All fields are required!');
      } else {
        setState(() {
          _isLoading = true;
        });
        await _firebaseServices.userSignUpMethod(context,
            _emailController.text.trim(), _passwordController.text.trim());
      }
    } catch (e) {
      AppSnackBar().showSnackBar(context, e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
      _fullNameController.clear();
      _emailController.clear();
      _passwordController.clear();
    }
  }
}
