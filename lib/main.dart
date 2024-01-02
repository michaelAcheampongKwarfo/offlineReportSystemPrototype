import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:offline_report_system/firebase_options.dart';
import 'package:offline_report_system/screens/contact_us.dart';
import 'package:offline_report_system/screens/forgot_password.dart';
import 'package:offline_report_system/screens/profile.dart';
import 'package:offline_report_system/screens/signup.dart';
import 'package:offline_report_system/screens/singin.dart';
import 'package:offline_report_system/screens/table_screen.dart';
import 'package:offline_report_system/screens/terms_of_service.dart';
import 'package:offline_report_system/widgets/app_colors.dart';
import 'package:offline_report_system/screens/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OfflineReportSystem',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.bgColor,
        appBarTheme: const AppBarTheme(
          color: AppColors.primaryColor,
        ),
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const TableScreen();
            } else {
              return const WelcomeScreen();
            }
          }),
      routes: {
        '/welcomeScreen': (context) => const WelcomeScreen(),
        '/signInScreen': (context) => const SignInScreen(),
        '/signUpScreen': (context) => const SignUpScreen(),
        '/forgotPasswordScreen': (context) => const ForgotPasswordScreen(),
        '/profileScreen': (context) => const ProfileScreen(),
        '/termsOfService': (context) => const TermsOfService(),
        '/contactUsScreen': (context) => const ContactUsScreen(),
        '/tableScreen': (context) => const TableScreen(),
      },
    );
  }
}
