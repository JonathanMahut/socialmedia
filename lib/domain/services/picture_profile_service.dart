import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ProfilePictureService {
  static final Reference _profilePicRef = FirebaseStorage.instance.ref().child('profilePic');

  static Future<String> uploadProfilePicture(String uid, File imageFile) async {
    try {
      // Create a reference to the profile picture path for the user
      Reference ref = _profilePicRef.child(uid);

      // Upload the file
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL of the uploaded image
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading profile picture: $e');
      // Handle the error appropriately (e.g., show an error message)
      return ''; // Or throw an exception
    }
  }
}
