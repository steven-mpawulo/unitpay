import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  dynamic error;

  Future getUserUid() async {
    String userUid = _auth.currentUser!.uid;
    return userUid;
  }

  // sign up user
  Future signup(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      var snackBar = SnackBar(
        content: SizedBox(
          height: 70.0,
          child: Center(
            child: Text(
              "${e.message.toString()}\n Please try again.",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.pinkAccent,
        duration: const Duration(
          seconds: 4,
        ),
        behavior: SnackBarBehavior.floating,
        width: 300.0,
      );
      error = snackBar;
    }
  }

  // sign in user
  Future signin(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      var snackBar = SnackBar(
        content: SizedBox(
          height: 70.0,
          child: Center(
            child: Text(
              "${e.message.toString()}\n Please try again.",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.pinkAccent,
        duration: const Duration(
          seconds: 4,
        ),
        behavior: SnackBarBehavior.floating,
        width: 300.0,
      );
      error = snackBar;
    }
  }

// sign out user
  Future signout() async {
    try {
      await _auth.signOut();
    } catch (e) {}
  }

  // reset password
  Future resetpassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      var snackBar = SnackBar(
        content: SizedBox(
          height: 70.0,
          child: Center(
            child: Text(
              "${e.message.toString()}\n Please try again.",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.pinkAccent,
        duration: const Duration(
          seconds: 4,
        ),
        behavior: SnackBarBehavior.floating,
        width: 300.0,
      );
      error = snackBar;
    }
  }

  Future confirmnewpassword(code, newPassword) async {
    try {
      await _auth.confirmPasswordReset(code: code, newPassword: newPassword);
    } on FirebaseAuthException catch (e) {
      var snackBar = SnackBar(
        content: SizedBox(
          height: 70.0,
          child: Center(
            child: Text(
              "${e.message.toString()}\n Please try again.",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.pinkAccent,
        duration: const Duration(
          seconds: 4,
        ),
        behavior: SnackBarBehavior.floating,
        width: 300.0,
      );
      error = snackBar;
    }
  }
}
