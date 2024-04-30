import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/auth/register/profile_pic.dart';
import 'package:social_media_app/models/enum/user_type.dart';
import 'package:social_media_app/services/auth_service.dart';

class RegisterViewModel extends ChangeNotifier {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validate = false;
  bool loading = false;
  String? username, email, country, password, cPassword, userType;
  // String gender = 'UNKNOWN';

  // bool isArtist = false;
  // List<TatooStyle>? selectedTatooStyles = [];
  FocusNode usernameFN = FocusNode();
  FocusNode emailFN = FocusNode();
  FocusNode countryFN = FocusNode();
  FocusNode passFN = FocusNode();
  //FocusNode genderFN = FocusNode();
  FocusNode cPassFN = FocusNode();
  AuthService auth = AuthService();

  register(BuildContext context) async {
    FormState form = formKey.currentState!;
    form.save();
    if (!form.validate()) {
      validate = true;
      notifyListeners();
      showInSnackBar(
          'Please fix the errors in red before submitting.', context);
    } else {
      if (password == cPassword) {
        loading = true;
        notifyListeners();
        try {
          bool success = await auth.createUser(
              name: username,
              email: email,
              password: password,
              country: country,
              userType: UserType.CLIENT.name
              // gender: gender,
              // isArtist: isArtist,
              // tatooStyles: selectedTatooStyles,
              );
          print(success);
          if (success) {
            Navigator.of(context).pushReplacement(
              CupertinoPageRoute(
                builder: (_) => const ProfilePicture(),
              ),
            );
            print(success);
          } else {
            showInSnackBar('User account Not successfully created ', context);
          }
          // if (isArtist == true) {
          //   Navigator.of(context).pushReplacement(
          //     CupertinoPageRoute(
          //       builder: (_) => TatooSelectionPage(),
          //     ),
          //   );
          //   showInSnackBar('Artist account created successfully', context);
          // }
        } catch (e) {
          loading = false;
          notifyListeners();
          print(e.toString());
          showInSnackBar(
              auth.handleFirebaseAuthError(e.toString()), context);
        }
        loading = false;
        notifyListeners();
      } else {
        showInSnackBar('The passwords does not match', context);
      }
    }
  }

  setEmail(val) {
    email = val;
    notifyListeners();
  }

  setPassword(val) {
    password = val;
    notifyListeners();
  }

  setName(val) {
    username = val;
    notifyListeners();
  }

  setConfirmPass(val) {
    cPassword = val;
    notifyListeners();
  }

  setCountry(val) {
    country = val;
    notifyListeners();
  }

  setUserType(val) {
    userType = val;
    notifyListeners();
  }

  getUserType() {
    return userType;
  }

  // setGender(val) {
  //   gender = val.toString();
  //   notifyListeners();
  // }

  // getGender() {
  //   return gender;
  // }

  // setArtist(val) {
  //   isArtist = val;
  //   notifyListeners();
  // }

  // getIsArtidt() {
  //   return isArtist;
  // }

  void showInSnackBar(String value, context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}
