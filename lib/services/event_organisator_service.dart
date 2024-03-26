import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media_app/models/enum/user_type.dart';
import 'package:social_media_app/models/event_organisator.dart';
import 'package:social_media_app/services/user_service.dart';
import 'package:social_media_app/utils/firebase.dart';

class EventOrganisatorService implements UserService {
  //get the authenticated uis
  String currentUid() {
    return firebaseAuth.currentUser!.uid;
  }

  //tells when the user is online or not and updates the last seen for the messages
  setUserStatus(bool isOnline) {
    var user = firebaseAuth.currentUser;
    if (user != null) {
      usersRef
          .doc(user.uid)
          .update({'isOnline': isOnline, 'lastSeen': Timestamp.now()});
    }
  }

  //updates user profile in the Edit Profile Screen
  @override
  updateProfile({
    File? image,
    String? username,
    String? bio,
    String? country,
    required UserType userType,
  }) async {
    DocumentSnapshot doc = await usersRef.doc(currentUid()).get();
    var users = EventOrganisator.fromJson(doc.data() as Map<String, dynamic>);
    users.username = username;
    users.bio = bio;
    users.country = country;
    if (userType != null) {
      users.userType = userType;
    } else {
      users.userType = UserType.EVENTORGANISATOR;
    }

    if (image != null) {
      users.photoUrl = await uploadImage(profilePic, image);
    }
    await usersRef.doc(currentUid()).update({
      'username': username,
      'bio': bio,
      'country': country,
      "photoUrl": users.photoUrl ?? '',
      "userType": userType ?? UserType.EVENTORGANISATOR,
    });

    return true;
  }

  @override
  Future<String> uploadImage(Reference ref, File file) {
    // TODO: implement uploadImage
    throw UnimplementedError();
  }
}
