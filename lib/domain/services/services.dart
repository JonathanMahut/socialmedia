import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media_app/core/utils/file_utils.dart';
import 'package:uuid/uuid.dart'; // Import uuid

abstract class Service {
// Function to upload images to Firebase Storage and retrieve the URL
  Future<String> uploadImage(Reference ref, File file) async {
    const uuid = Uuid(); // Create a Uuid instance
    String ext = FileUtils.getFileExtension(file);
    Reference storageReference = ref.child("${uuid.v4()}.$ext");
    UploadTask uploadTask = storageReference.putFile(file);
    await uploadTask.whenComplete(() => null);
    String fileUrl = await storageReference.getDownloadURL();
    return fileUrl;
  }
}
