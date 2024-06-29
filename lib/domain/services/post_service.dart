import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media_app/core/utils/firebase.dart';
import 'package:social_media_app/data/models/post.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/user.dart';

class PostService {
  // Upload post to Firestore
  Future<void> uploadPost(List<File> mediaFiles, String location, String description, bool isFlash, String? postType,
      List<String> hashtags) async {
    // Generate a unique postId
    String postId = const Uuid().v1();

    // Upload each media file and get download URLs
    List<String> mediaUrls = [];
    for (var mediaFile in mediaFiles) {
      String mediaUrl = await uploadImage(posts, mediaFile);
      mediaUrls.add(mediaUrl);
    }

    // Create a PostModel object
    PostModel post = PostModel(
      id: firebaseAuth.currentUser!.uid,
      postId: postId,
      ownerId: firebaseAuth.currentUser!.uid,
      username: firebaseAuth.currentUser!.displayName ?? '',
      location: location,
      description: description,
      mediaUrls: mediaUrls, // Store the list of media URLs
      isFlashDispo: isFlash,
      timestamp: Timestamp.now(),
      postType: postType, // Store the post type
      hashtags: hashtags, // Store the hashtags
    );

    // Save the post to Firestore
    await postRef.doc(postId).set(post.toJson());
  }

  // Upload profile picture to Firebase Storage
  Future<String> uploadImage(Reference ref, File file) async {
    String fileName = const Uuid().v1();
    UploadTask uploadTask = ref.child(fileName).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void removeLikeFromNotification(String ownerId, String postId, String currentUserId) {
    notificationRef.doc(ownerId).collection('notifications').doc(postId).get().then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  void addLikesToNotification(String type, String username, String currentUserId, String postId, String mediaUrl,
      String ownerId, String userDp) {
    final DateTime timestamp = DateTime.now();
    notificationRef.doc(ownerId).collection('notifications').doc(postId).set({
      "type": type,
      "username": username,
      "userId": currentUserId,
      "userDp": userDp,
      "postId": postId,
      "mediaUrl": mediaUrl,
      "timestamp": timestamp,
    });
  }

  // Method to upload a comment
  Future<void> uploadComment(
    String currentUserId,
    String comment,
    String postId,
    String ownerId,
    String mediaUrl,
  ) async {
    // 1. Fetch user details (username and profile picture)
    DocumentSnapshot userDoc = await usersRef.doc(currentUserId).get();
    UserModel user = UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
    // 2. Upload the comment
    await commentRef.doc(postId).collection('comments').add({
      'userId': currentUserId,
      'comment': comment,
      'timestamp': Timestamp.now(),
      'userDp': user.photoUrl,
      'username': user.username,
    });
    // 3. Add notification for the post owner (if it's not the commenter themselves)
    if (currentUserId != ownerId) {
      await notificationRef.doc(ownerId).collection('notifications').add({
        'type': 'comment',
        'username': user.username,
        'userId': currentUserId,
        'userDp': user.photoUrl,
        'postId': postId,
        'mediaUrl': mediaUrl,
        'timestamp': Timestamp.now(),
      });
    }
  }

  // Upload profile picture to Firebase Storage and update user profile
  Future<void> uploadProfilePicture(File image, User user) async {
    // Upload the image and get the download URL
    String downloadUrl = await uploadImage(profilePic, image);

    // Update the user's photoUrl in Firestore
    await usersRef.doc(user.uid).update({'photoUrl': downloadUrl});
  }
}
