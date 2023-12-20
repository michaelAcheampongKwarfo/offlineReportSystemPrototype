// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:offline_report_system/widgets/app_snackbar.dart';

class FirebaseServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User get user => _firebaseAuth.currentUser!;

  // user sign in method
  Future<void> userSignInMethod(
      BuildContext context, String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      AppSnackBar().showSnackBar(context, e.message!);
    }
  }

// user sign up method
  Future<void> userSignUpMethod(
      BuildContext context, String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      AppSnackBar().showSnackBar(context, e.message!);
    }
  }

  // send email verificatio
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      await _firebaseAuth.currentUser!.sendEmailVerification();
      AppSnackBar().showSnackBar(
          context, 'An email verification link has been sent to ${user.email}');
    } on FirebaseAuthException catch (e) {
      AppSnackBar().showSnackBar(context, e.message!);
    }
  }

  Future<void> userSignOutMethod(BuildContext context) async {
    try {
      _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      AppSnackBar().showSnackBar(context, e.message!);
    }
  }
}
