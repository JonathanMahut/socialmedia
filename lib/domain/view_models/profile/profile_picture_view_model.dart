import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:social_media_app/domain/services/auth_service.dart';

import '../../../data/models/user.dart';
import '../../../presentation/screens/mainscreen.dart';
import '../../services/picture_profile_service.dart';

class ProfilePictureViewModel extends ChangeNotifier {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  UserModel? _user; // Store the received UserModel
  File? mediaUrl; // Store the selected image file
  String? imgLink; // Store the uploaded image URL

  // Setter for the UserModel
  void setUser(UserModel user) {
    _user = user;
  }

  // Pick image from gallery or camera
  Future<void> pickImage({bool camera = false}) async {
    loading = true;
    notifyListeners();
    try {
      XFile? pickedFile = await ImagePicker().pickImage(
        source: camera ? ImageSource.camera : ImageSource.gallery,
      );
      if (pickedFile != null) {
        mediaUrl = File(pickedFile.path);
      }
    } catch (e) {
      print(e);
      showInSnackBar('Error picking image.', scaffoldKey.currentContext!);
    }
    loading = false;
    notifyListeners();
  }

  // Upload the profile picture and update the UserModel
  Future<void> uploadProfilePicture(BuildContext context) async {
    loading = true;
    notifyListeners();
    try {
      if (mediaUrl != null && _user != null) {
        // Upload the image using ProfilePictureService
        imgLink = await ProfilePictureService.uploadProfilePicture(_user!.id, mediaUrl!);

        // Update the UserModel with the new profile picture URL
        UserModel updatedUser = _user!.copyWith(photoUrl: imgLink);
        await AuthService().updateProfilePicture(updatedUser.id, imgLink!);

        // Navigate to the home page
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (_) => const TabScreen(),
          ),
        );
      } else {
        showInSnackBar('Please select an image.', context);
      }
    } catch (e) {
      print(e);
      showInSnackBar('Error uploading image.', context);
    }
    loading = false;
    notifyListeners();
  }

  // Reset the selected image
  void resetImage() {
    mediaUrl = null;
    imgLink = null;
    notifyListeners();
  }

  void showInSnackBar(String value, BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}
