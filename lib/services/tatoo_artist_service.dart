import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media_app/models/enum/gender_type.dart';
import 'package:social_media_app/models/enum/tatoo_style.dart';
import 'package:social_media_app/models/tatoo_artist.dart';
import 'package:social_media_app/services/user_service.dart';
import 'package:social_media_app/utils/firebase.dart';

class TatooArtistService extends UserService {
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
  updateProfile({
    File? image,
    String? username,
    String? bio,
    String? country,
    String? gender,
    List<TatooStyle>?
        tatooStyles, // Nouvelle propriété pour les styles de tatouage
  }) async {
    DocumentSnapshot doc = await usersRef.doc(currentUid()).get();
    var users = TatooArtist.fromJson(doc.data() as Map<String, dynamic>);
    users.username = username;
    users.bio = bio;
    users.country = country;
    users.gender = gender;
    // users.isArtist = isArtist;
    users.tatooStyles = tatooStyles; // Attribution des styles de tatouage
    if (image != null) {
      users.photoUrl = await uploadImage(profilePic, image);
    }
    await usersRef.doc(currentUid()).update({
      'username': username,
      'bio': bio,
      'country': country,
      "photoUrl": users.photoUrl ?? '',
      "gender": users.gender ?? GenderType.OTHER,
      // Sérialisation des styles de tatouage
      "tatooStyles": users.tatooStyles != null
          ? users.tatooStyles!.map((style) => style.index).toList()
          : null,
    });

    return true;
  }

  @override
  Future<String> uploadImage(Reference ref, File file) {
    // TODO: implement uploadImage
    throw UnimplementedError();
  }
}
