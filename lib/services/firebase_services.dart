// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:offline_report_system/widgets/app_snackbar.dart';

class FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Sign in user with email and password
  Future<bool> userSignIn(
      String email, String password, BuildContext context) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return true; // Sign-in successful
    } on FirebaseAuthException catch (e) {
      AppSnackBar().showSnackBar(context, _getErrorMessage(e));
      return false; // Sign-in failed
    } catch (e) {
      AppSnackBar().showSnackBar(context, e.toString());
      return false; // Sign-in failed
    }
  }

  // Sign up user with email and password
  Future<bool> userSignUp(
      String email, String password, BuildContext context) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true; // Sign-up successful
    } on FirebaseAuthException catch (e) {
      AppSnackBar().showSnackBar(context, _getErrorMessage(e));
      return false; // Sign-up failed
    } catch (e) {
      AppSnackBar().showSnackBar(context, e.toString());
      return false; // Sign-up failed
    }
  }

  // Get a more user-friendly error message based on the Firebase exception
  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'user-not-found':
        return 'No user found with that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      default:
        return 'Authentication failed: ${e.message}';
    }
  }

  // sign out user
  Future<void> userSignOut(BuildContext context) async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      AppSnackBar().showSnackBar(context, e.message.toString());
    } catch (e) {
      AppSnackBar().showSnackBar(context, e.toString());
    }
  }
}
