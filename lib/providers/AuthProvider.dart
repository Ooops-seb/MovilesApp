import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  AuthProvider() {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      _isAuthenticated = user != null;
    } catch (e) {
      _isAuthenticated = false;
    }
    notifyListeners();
  }

  Future<UserCredential?> signIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication authentication =
          await googleUser.authentication;

      final credentials = GoogleAuthProvider.credential(
          accessToken: authentication.accessToken,
          idToken: authentication.idToken);

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credentials);
      await checkAuthStatus();
      return userCredential;
    } catch (e) {
      _isAuthenticated = false;
      notifyListeners();
      return null;
    }
  }

  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    _isAuthenticated = false;
    notifyListeners();
  }
}
