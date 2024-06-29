import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:social_media_app/data/models/enum/user_type.dart';
import 'package:social_media_app/data/models/user.dart';
import 'package:social_media_app/domain/services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService;

  AuthViewModel(this._authService);

  // 1. Email/Password Sign Up
  Future<UserModel?> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String country,
    required String password,
    required UserType userType,
  }) async {
    try {
      UserModel? user = await _authService.createUserWithEmailAndPassword(
        name: name,
        email: email,
        country: country,
        password: password,
        userType: userType,
      );
      if (user != null) {
        notifyListeners(); // Notify listeners about successful sign-up
      }
      return user;
    } catch (e) {
      // Handle sign-up errors (e.g., display error messages)
      print('Sign up error: ${e.toString()}');
      return null;
    }
  }

  // 2. Email/Password Sign In
  Future<UserModel?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserModel? user = await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user != null) {
        notifyListeners(); // Notify listeners about successful sign-in
      }
      return user;
    } catch (e) {
      // Handle sign-in errors (e.g., display error messages)
      print('Sign inerror: ${e.toString()}');
      return null;
    }
  }

  // 3. Google Sign In
  Future<UserModel?> signInWithGoogle() async {
    try {
      UserModel? user = await _authService.signInWithGoogle();
      if (user != null) {
        notifyListeners(); // Notify listeners about successful Google sign-in
      }
      return user;
    } catch (e) {
      // Handle Google sign-in errors
      print('Google sign-in error: ${e.toString()}');
      return null;
    }
  }

  // 4. Forgot Password
  Future<void> forgotPassword(String email) async {
    try {
      await _authService.forgotPassword(email);
      // Optionally show a success message
    } catch (e) {
      // Handle forgot password errors
      print('Forgot password error: ${e.toString()}');
    }
  }

  // 5. Log Out
  Future<void> logOut() async {
    await _authService.logOut();
    notifyListeners(); // Notify listeners about logout
  }

  // 6. Get Current User (if needed)
  User? getCurrentUser() {
    return _authService.getCurrentUser();
  }

// ... Add other methods as needed, such as profile updates, etc. ...
}
