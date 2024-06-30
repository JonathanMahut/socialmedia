import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/core/utils/validation.dart';
import 'package:social_media_app/data/models/enum/user_type.dart';
import 'package:social_media_app/domain/services/auth_service.dart';

import '../../../data/models/user.dart';
import '../../../presentation/screens/artist_home_screen.dart';
import '../../../presentation/screens/client_home_screen.dart';

import '../../../presentation/screens/event_organisator_home_screen.dart';
import '../../../presentation/screens/supplier_home_screen.dart';

class LoginViewModel extends ChangeNotifier {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validate = false;
  bool loading = false;
  String? email, password;
  UserType? currentUserType;
  FocusNode emailFN = FocusNode();
  FocusNode passFN = FocusNode();

  final AuthService _authService = AuthService();

  Future<void> login(BuildContext context) async {
    FormState form = formKey.currentState!;
    form.save();
    if (!form.validate()) {
      validate = true;
      notifyListeners();
      showInSnackBar('Please fix the errors in red before submitting.', context);
    } else {
      loading = true;
      notifyListeners();
      try {
        final UserModel? user = await _authService.signInWithEmailAndPassword(
          email: email!,
          password: password!,
        );

        if (user != null) {
          // Navigate based on user type
          Navigator.of(context).pushReplacement(
            CupertinoPageRoute(
              builder: (_) {
                switch (user.userType) {
                  case UserType.client:
                    return const ClientHomeScreen();
                  case UserType.tattooArtist:
                    return const ArtistHomeScreen();
                  case UserType.supplier:
                    return const SupplierHomeScreen();
                  case UserType.eventOrganizer:
                    return const EventOrganizerHomeScreen();
                  default:
                    // Handle unknown user type, maybe navigate to an error screen
                    return const Scaffold(
                      body: Center(child: Text('Unknown User Type')),
                    );
                }
              },
            ),
          );
        } else {
          showInSnackBar('Login failed. Please check your credentials.', context);
        }
      } catch (e) {
        loading = false;
        notifyListeners();
        print(e);
        showInSnackBar(_authService.handleFirebaseAuthError(e as FirebaseAuthException), context);
      } finally {
        loading = false;
        notifyListeners();
      }
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    loading = true;
    notifyListeners();

    try {
      UserModel? user = await _authService.signInWithGoogle();
      if (user != null) {
        // Navigate based on user type (similar to login method)
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (_) {
              switch (user.userType) {
                case UserType.client:
                  return const ClientHomeScreen();
                case UserType.tattooArtist:
                  return const ArtistHomeScreen();
                case UserType.supplier:
                  return const SupplierHomeScreen();
                case UserType.eventOrganizer:
                  return const EventOrganizerHomeScreen();
                default:
                  return const Scaffold(
                    body: Center(child: Text('Unknown User Type')),
                  );
              }
            },
          ),
        );
      } else {
        showInSnackBar('Google Sign-In failed.', context);
      }
    } catch (e) {
      print(e.toString());
      showInSnackBar('An error occurred during Google Sign-In.', context);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> forgotPassword(BuildContext context) async {
    loading = true;
    notifyListeners();
    FormState form = formKey.currentState!;
    form.save();
    if (Validations.validateEmail(email) != null) {
      showInSnackBar('Please input a valid email to reset your password.', context);
    } else {
      try {
        await _authService.forgotPassword(email!);
        showInSnackBar(
          'Please check your email for instructions to reset your password',
          context,
        );
      } catch (e) {
        showInSnackBar(e.toString(), context);
      }
    }
    loading = false;
    notifyListeners();
  }

  void setEmail(String val) {
    email = val;
    notifyListeners();
  }

  void setPassword(String val) {
    password = val;
    notifyListeners();
  }

  void showInSnackBar(String value, context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}
