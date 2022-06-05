import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationServices {
  final FirebaseAuth _firebaseAuth;

  AuthenticationServices(this._firebaseAuth);

  Future<bool> signIn({required String email, required String password}) async {
    try {
      _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      debugPrint("SignIn Email berhasil");
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message ?? "Unknown Error");
      return false;
    }
  }

  Future<bool> signUp({required String email, required String password}) async {
    try {
      _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message ?? "Unknown error");
      return false;
    }
  }
}

class AuthenticationGoogle {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ]);

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future<bool> signIn() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        _user = googleUser;
      }
      print("User google ${_user!.email}");
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message ?? "Unknown Error");
      return false;
    }
  }
}
