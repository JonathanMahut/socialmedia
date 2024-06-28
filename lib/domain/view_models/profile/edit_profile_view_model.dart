import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/core/utils/constants.dart';
import 'package:social_media_app/data/models/enum/app_theme.dart';
import 'package:social_media_app/data/models/enum/gender_type.dart';
import 'package:social_media_app/data/models/enum/subscription_type.dart';
import 'package:social_media_app/data/models/enum/user_type.dart';
import 'package:social_media_app/data/models/event.dart';
import 'package:social_media_app/data/models/product_model.dart';
import 'package:social_media_app/data/models/social_media_link_model.dart';
import 'package:social_media_app/data/models/user.dart';
import 'package:social_media_app/domain/services/user_service.dart';

class EditProfileViewModel extends ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validate = false;
  bool loading = false;
  UserService userService = UserService();
  final picker = ImagePicker();
  UserModel? user;
  String? country;
  String? username;
  String? bio;
  String? displayName;
  String? phoneNumber;
  String? language;
  String? countryCode;
  String? postalAddress;
  String? city;
  List<String>? specialties;
  AppTheme? theme;
  SubscriptionType? subscriptionType;
  DateTime? subscriptionStartDate;
  DateTime? subscriptionEndDate;
  bool? isTrialPeriod;
  String? portfolioUrl;
  List<EventModel>? organizedEvents;
  String? companyName;
  List<Product>? products;
  String? websiteUrl;
  List<SocialMediaLink>? socialMediaLinks;
  File? image;
  String? imgLink;
  String? userType; // Store userType as String
  String? gender; // Store gender as String
  UserType? _userType; // Store userType as an enum
  GenderType? _gender; // Store gender as an enum

  UserType? getUserType() {
    return _userType;
  }

  // Setter for userType (converting from String to enum)
  setUserType(String userTypeString) {
    _userType = _userTypeFromString(userTypeString);
    notifyListeners();
  }

  // Getter for gender
  GenderType? getGender() {
    return _gender;
  }

  // Setter for gender (converting from String to enum)
  setGender(String genderString) {
    _gender = _genderTypeFromString(genderString);
    notifyListeners();
  }

  UserType? _userTypeFromString(String? userTypeString) {
    if (userTypeString != null) {
      try {
        return UserType.values.byName(userTypeString);
      } catch (e) {
        print('Invalid UserType: $userTypeString');
      }
    }
    return null;
  }

  GenderType? _genderTypeFromString(String? genderString) {
    if (genderString != null) {
      try {
        return GenderType.values.byName(genderString);
      } catch (e) {
        print('Invalid GenderType: $genderString');
      }
    }
    return null;
  }

  setDisplayName(String val) {
    print('SetDisplayName $val');
    displayName = val;
    notifyListeners();
  }

  setPhoneNumber(String val) {
    print('SetPhoneNumber $val');
    phoneNumber = val;
    notifyListeners();
  }

  setLanguage(String val) {
    print('SetLanguage $val');
    language = val;
    notifyListeners();
  }

  setCountryCode(String val) {
    print('SetCountryCode $val');
    countryCode = val;
    notifyListeners();
  }

  setPostalAddress(String val) {
    print('SetPostalAddress $val');
    postalAddress = val;
    notifyListeners();
  }

  setUser(UserModel val) {
    user = val;
    notifyListeners();
  }

  setCity(String val) {
    print('SetCity $val');
    city = val;
    notifyListeners();
  }

  setImage(UserModel user) {
    imgLink = user.photoUrl;
  }

  setSpecialties(List<String> val) {
    print('SetSpecialties $val');
    specialties = val;
    notifyListeners();
  }

  setTheme(AppTheme val) {
    print('SetTheme $val');
    theme = val;
    notifyListeners();
  }

  setCountry(String val) {
    print('SetCountry $val');
    country = val;
    notifyListeners();
  }

  setSubscriptionStartDate(DateTime val) {
    print('SetSubscriptionStartDate $val');
    subscriptionStartDate = val;
    notifyListeners();
  }

  setSubscriptionEndDate(DateTime val) {
    print('SetSubscriptionEndDate $val');
    subscriptionEndDate = val;
    notifyListeners();
  }

  setIsTrialPeriod(bool val) {
    print('SetIsTrialPeriod $val');
    isTrialPeriod = val;
    notifyListeners();
  }

  setSubscriptionType(SubscriptionType val) {
    print('SetSubscriptionType $val');
    subscriptionType = val;
    notifyListeners();
  }

  setBio(String val) {
    print('SetBio $val');
    bio = val;
    notifyListeners();
  }

  setPortfolioUrl(String val) {
    print('SetPortfolioUrl $val');
    portfolioUrl = val;
    notifyListeners();
  }

  setOrganizedEvents(List<EventModel> val) {
    print('SetOrganizedEvents $val');
    organizedEvents = val;
    notifyListeners();
  }

  setUsername(String val) {
    print('SetUsername $val');
    username = val;
    notifyListeners();
  }

  setCompanyName(String val) {
    print('SetCompanyName $val');
    companyName = val;
    notifyListeners();
  }

  setProducts(List<Product> val) {
    print('SetProducts $val');
    products = val;
    notifyListeners();
  }

  setSocialMediaLinks(List<SocialMediaLink> val) {
    print('SetSocialMediaLinks $val');
    socialMediaLinks = val;
    notifyListeners();
  }

  setWebsiteUrl(String val) {
    print('SetWebsiteUrl $val');
    websiteUrl = val;
    notifyListeners();
  }

  getCountry() {
    return country;
  }

  getBio() {
    return bio;
  }

  getUsername() {
    return username;
  }

  getImage() {
    return imgLink;
  }

  getForm() {
    return formKey;
  }

  getScaffold() {
    return scaffoldKey;
  }

  getValidate() {
    return validate;
  }

  getLoading() {
    return loading;
  }

  editProfile(BuildContext context) async {
    FormState form = formKey.currentState!;
    form.save();
    if (!form.validate()) {
      validate = true;
      notifyListeners();
      showInSnackBar('Please fix the errors in red before submitting.', context);
    } else {
      try {
        loading = true;
        notifyListeners();

        // Convert userType and gender stringsto enums
        UserType? userTypeValue = this._userTypeFromString(userType); // Pass the string property 'userType'
        GenderType? genderValue = this._genderTypeFromString(gender); // Pass the string property 'gender'

        bool success = await userService.updateProfile(
          image: image,
          username: username,
          bio: bio,
          country: country,
          // Use the parameter names correctly:
          userTypeString: userTypeValue?.name, // Pass the enum name as a string
          genderString: genderValue?.name, // Pass the enum name as a string
          displayName: displayName,
          phoneNumber: phoneNumber,
          language: language,
          countryCode: countryCode,
          postalAddress: postalAddress,
          city: city,
          specialties: specialties,
          theme: theme,
          subscriptionType: subscriptionType,
          subscriptionStartDate: subscriptionStartDate,
          subscriptionEndDate: subscriptionEndDate,
          isTrialPeriod: isTrialPeriod,
          portfolioUrl: portfolioUrl,
          organizedEvents: organizedEvents,
          companyName: companyName,
          products: products,
          websiteUrl: websiteUrl,
          socialMediaLinks: socialMediaLinks,
        );
        print(success);
        if (success) {
          clear();
          Navigator.pop(context);
        }
      } catch (e) {
        loading = false;
        notifyListeners();
        print(e);
      }
      loading = false;
      notifyListeners();
    }
  }

  pickImage({bool camera = false, BuildContext? context}) async {
    loading = true;
    notifyListeners();
    try {
      XFile? pickedFile = await picker.pickImage(
        source: camera ? ImageSource.camera : ImageSource.gallery,
      );
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile!.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Constants.lightAccent,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
          ),
          IOSUiSettings(
            minimumAspectRatio: 1.0,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
          ),
          // WebUiSettings(
          //   context: context,
          // ),
        ],
      );
      image = File(croppedFile!.path);
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      showInSnackBar('Cancelled', context);
    }
  }

  clear() {
    image = null;
    notifyListeners();
  }

  void showInSnackBar(String value, context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}
