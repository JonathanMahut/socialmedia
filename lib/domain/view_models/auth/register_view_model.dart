import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/domain/services/auth_service.dart';
import 'package:social_media_app/presentation/pages/auth/register/profile_pic.dart';

import '../../../data/models/enum/app_theme.dart';
import '../../../data/models/enum/gender_type.dart';
import '../../../data/models/enum/user_type.dart';
import '../../../data/models/user.dart';
import '../../../presentation/screens/mainscreen.dart';

class RegisterViewModel extends ChangeNotifier {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validate = false;
  bool loading = false;
  String? username, email, country, password, cPassword;
  UserType? selectedUserType;
  GenderType? selectedGender;
  AppTheme selectedTheme = AppTheme.system;
  String? displayName, phoneNumber, website, language, countryCode, postalAddress, city;
  List<String>? specialties;
  FocusNode usernameFN = FocusNode();
  FocusNode emailFN = FocusNode();
  FocusNode countryFN = FocusNode();
  FocusNode passFN = FocusNode();
  FocusNode cPassFN = FocusNode();

  final AuthService _authService = AuthService(); // Instance of AuthService

  // Getters for all fields
  String? get name => username;
  String? get userEmail => email;
  String? get userCountry => country;
  String? get userPassword => password;
  String? get confirmPassword => cPassword;
  UserType? get userType => selectedUserType;
  GenderType? get gender => selectedGender;
  AppTheme get theme => selectedTheme;
  String? get userDisplayName => displayName;
  String? get userPhoneNumber => phoneNumber;
  String? get userWebsite => website;
  String? get userLanguage => language;
  String? get userCountryCode => countryCode;
  String? get userPostalAddress => postalAddress;
  String? get userCity => city;
  List<String>? get userSpecialties => specialties;

  Future<void> register(BuildContext context) async {
    FormState form = formKey.currentState!;
    form.save();
    if (!form.validate()) {
      validate = true;
      notifyListeners();
      showInSnackBar('Please fix the errors in red before submitting.', context);
    } else {
      if (password == cPassword) {
        loading = true;
        notifyListeners();
        try {
          final UserModel? newUser = await _authService.createUserWithEmailAndPassword(
            name: username!,
            email: email!,
            country: country!,
            password: password!,
            userType: selectedUserType!,
            displayName: displayName,
            phoneNumber: phoneNumber,
            website: website,
            language: language,
            countryCode: countryCode,
            postalAddress: postalAddress,
            city: city,
            gender: selectedGender,
            specialties: specialties,
            theme: selectedTheme,
          );

          if (newUser != null) {
            Navigator.of(context).pushReplacement(
              CupertinoPageRoute(
                builder: (_) => ProfilePicture(user: newUser),
              ),
            );
          } else {
            showInSnackBar('User account not successfully created.', context);
          }
        } catch (e) {
          loading = false;
          notifyListeners();
          print(e.toString());
          showInSnackBar(_authService.handleFirebaseAuthError(e as FirebaseAuthException), context);
        } finally {
          loading = false;
          notifyListeners();
        }
      } else {
        showInSnackBar('The passwords do not match.', context);
      }
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    loading = true;
    notifyListeners();

    try {
      UserModel? user = await _authService.signInWithGoogle();
      if (user != null) {
        // Navigate to the Home screen after successful sign-in
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (_) => const TabScreen(), // Replace with your actual Home screen widget
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

  // Setter methods for all fields
  void setEmail(String val) {
    email = val;
    notifyListeners();
  }

  void setPassword(String val) {
    password = val;
    notifyListeners();
  }

  void setName(String val) {
    username = val;
    notifyListeners();
  }

  void setConfirmPass(String val) {
    cPassword = val;
    notifyListeners();
  }

  void setCountry(String val) {
    country = val;
    notifyListeners();
  }

  void setSelectedUserType(UserType? userType) {
    selectedUserType = userType;
    notifyListeners();
  }

  void setSelectedGender(GenderType? gender) {
    selectedGender = gender;
    notifyListeners();
  }

  void setSelectedTheme(AppTheme theme) {
    selectedTheme = theme;
    notifyListeners();
  }

  void setDisplayName(String? val) {
    displayName = val;
    notifyListeners();
  }

  void setPhoneNumber(String? val) {
    phoneNumber = val;
    notifyListeners();
  }

  void setWebsite(String? val) {
    website = val;
    notifyListeners();
  }

  void setLanguage(String? val) {
    language = val;
    notifyListeners();
  }

  void setCountryCode(String? val) {
    countryCode = val;
    notifyListeners();
  }

  void setPostalAddress(String? val) {
    postalAddress = val;
    notifyListeners();
  }

  void setCity(String? val) {
    city = val;
    notifyListeners();
  }

  void setSpecialties(List<String>? val) {
    specialties = val;
    notifyListeners();
  }

  UserType? getUserType() {
    return selectedUserType;
  }

  void showInSnackBar(String value, context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}
