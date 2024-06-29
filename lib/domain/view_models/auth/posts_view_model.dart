import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/core/utils/constants.dart';
import 'package:social_media_app/core/utils/firebase.dart';
import 'package:social_media_app/data/models/post.dart';
import 'package:social_media_app/domain/services/post_service.dart';
import 'package:social_media_app/domain/services/user_service.dart';
import 'package:social_media_app/presentation/screens/mainscreen.dart';

class PostsViewModel extends ChangeNotifier {
  //Services
  UserService userService = UserService();

  PostService postService = PostService();

  //Keys
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //Variables
  bool loading = false;
  String? username;
  File? mediaUrl;
  final picker = ImagePicker();
  String? location;
  Position? position;
  Placemark? placemark;
  String? bio;
  String? description;
  String? email;
  String? commentData;
  String? ownerId;
  String? userId;
  String? type;
  File? userDp;
  String? imgLink;
  bool edit = false;
  String? id;
  bool isFlash = false;
  String? currentUserType;

  //controllers
  TextEditingController locationTEC = TextEditingController();

  String? _postType;
  List<String> _hashtags = [];

  // Getters for postType and hashtags
  String? get postType => _postType;
  List<String> get hashtags => _hashtags;

  // Setters for postType and hashtags (you might already have these)
  setPostType(String? type) {
    _postType = type;
    notifyListeners();
  }

  addHashtag(String hashtag) {
    _hashtags.add(hashtag);
    notifyListeners();
  }

  removeHashtag(String hashtag) {
    _hashtags.remove(hashtag);
    notifyListeners();
  }

  //Setters
  setEdit(bool val) {
    edit = val;
    notifyListeners();
  }

  setPost(PostModel post) {
    description = post.description;
    // Handle mediaUrls (list) instead of mediaUrl (single string)
    if (post.mediaUrls.isNotEmpty) {
      imgLink = post.mediaUrls[0]; // Assuming you want to display the first image for now
    } else {
      imgLink = null; // No media URLs available
    }
    location = post.location;
    edit = true;
    edit = false; // This line seems redundant, you might want to remove it
    notifyListeners();
  }

  setUsername(String val) {
    print('SetName $val');
    username = val;
    notifyListeners();
  }

  setDescription(String val) {
    print('SetDescription $val');
    description = val;
    notifyListeners();
  }

  setLocation(String val) {
    print('SetCountry $val');
    location = val;
    notifyListeners();
  }

  setBio(String val) {
    print('SetBio $val');
    bio = val;
    notifyListeners();
  }

  setIsFlash(bool val) {
    print('SetFlash $val');
    isFlash = val;
    notifyListeners();
  }

  setCurrentUsertype(String val) {
    print('SetUserType $val');
    currentUserType = val;
    notifyListeners();
  }

  //Functions
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
              ]),
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
      mediaUrl = File(croppedFile!.path);
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      if (context!.mounted) {
        showInSnackBar('Cancelled', context);
      }
    }
  }

  getLocation() async {
    loading = true;
    notifyListeners();
    LocationPermission permission = await Geolocator.checkPermission();
    print(permission);
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      LocationPermission rPermission = await Geolocator.requestPermission();
      print(rPermission);
      await getLocation();
    } else {
      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(position!.latitude, position!.longitude);
      placemark = placemarks[0];
      location = " ${placemarks[0].locality}, ${placemarks[0].country}";
      locationTEC.text = location!;
      print(location);
    }
    loading = false;
    notifyListeners();
  }

  uploadPosts(BuildContext context) async {
    try {
      loading = true;
      notifyListeners(); // Access the postType and hashtags member variables
      await postService.uploadPost([mediaUrl!], location!, description!, isFlash, this.postType, this.hashtags);
      loading = false;
      resetPost();
      notifyListeners();
    } catch (e) {
      print(e);
      loading = false;
      resetPost();
      showInSnackBar('Error uploading post', context);
      notifyListeners();
    }
  }

  uploadProfilePicture(BuildContext context) async {
    if (mediaUrl == null) {
      showInSnackBar('Please select an image', context);
    } else {
      try {
        loading = true;
        notifyListeners();
        await postService.uploadProfilePicture(mediaUrl!, firebaseAuth.currentUser!);
        loading = false;

        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (_) => const TabScreen()));
        notifyListeners();
      } catch (e) {
        print(e);
        loading = false;
        if (context.mounted) {
          showInSnackBar('Uploaded successfully!', context);
        }
        notifyListeners();
      }
    }
  }

  resetPost() {
    mediaUrl = null;
    description = null;
    location = null;
    edit = false;
    isFlash = false;
    notifyListeners();
  }

  void showInSnackBar(String value, context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}