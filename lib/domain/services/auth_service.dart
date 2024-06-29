import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_media_app/core/utils/firebase.dart';
import 'package:social_media_app/data/models/enum/app_theme.dart';
import 'package:social_media_app/data/models/enum/gender_type.dart';
import 'package:social_media_app/data/models/enum/subscription_type.dart';
import 'package:social_media_app/data/models/enum/user_type.dart';
import 'package:social_media_app/data/models/user.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<UserModel?> createUserWithEmailAndPassword({
    required String name,
    required String email,
    required String country,
    required String password,
    required UserType userType,
    String? displayName,
    String? phoneNumber,
    String? website,
    String? language,
    String? countryCode,
    String? postalAddress,
    String? city,
    GenderType? gender,
    List<String>? specialties,
    AppTheme theme = AppTheme.system,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        UserModel newUser = UserModel(
          id: result.user!.uid,
          email: email,
          username: name,
          userType: userType,
          photoUrl: result.user!.photoURL,
          country: country,
          displayName: displayName,
          phoneNumber: phoneNumber,
          language: language ?? 'en',
          countryCode: countryCode,
          postalAddress: postalAddress,
          city: city,
          gender: gender,
          specialties: specialties,
          theme: theme,
          signedUpAt: DateTime.now(),
          lastSeen: DateTime.now(),
        );

        await saveUserToFirestore(newUser);
        notifyListeners();
        return newUser;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<void> saveUserToFirestore(UserModel user) async {
    await usersRef.doc(user.id).set(user.toJson());
  }

  Future<UserModel?> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        DocumentSnapshot userSnapshot = await usersRef.doc(result.user!.uid).get();
        if (userSnapshot.exists) {
          notifyListeners();
          return UserModel.fromJson(userSnapshot.data() as Map<String, dynamic>);
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential = await _auth.signInWithCredential(credential);

        if (userCredential.user != null) {
          DocumentSnapshot userSnapshot = await usersRef.doc(userCredential.user!.uid).get();
          if (userSnapshot.exists) {
            notifyListeners();
            return UserModel.fromJson(userSnapshot.data() as Map<String, dynamic>);
          } else {
            UserModel newUser = UserModel(
              id: userCredential.user!.uid,
              email: userCredential.user!.email ?? '',
              username: googleUser.displayName ?? '',
              userType: UserType.client,
              photoUrl: userCredential.user!.photoURL,
              country: '',
              signedUpAt: DateTime.now(),
              lastSeen: DateTime.now(),
            );
            await saveUserToFirestore(newUser);
            notifyListeners();
            return newUser;
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<void> forgotPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> logOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    notifyListeners();
  }

  Future<void> startTrial(String userId, SubscriptionType subscriptionType) async {
    final now = DateTime.now();
    final trialEndDate = now.add(const Duration(days: 30));

    await usersRef.doc(userId).update({
      'subscriptionType': subscriptionType.name,
      'subscriptionStartDate': now,
      'subscriptionEndDate': trialEndDate,
      'isTrialPeriod': true,
    });
    notifyListeners();
  }

  Future<void> upgradeSubscription(String userId, SubscriptionType subscriptionType) async {
    final now = DateTime.now();
    final subscriptionEndDate = now.add(const Duration(days: 365));

    await usersRef.doc(userId).update({
      'subscriptionType': subscriptionType.name,
      'subscriptionStartDate': now,
      'subscriptionEndDate': subscriptionEndDate,
      'isTrialPeriod': false,
    });
    notifyListeners();
  }

  Future<void> cancelSubscription(String userId) async {
    await usersRef.doc(userId).update({
      'subscriptionType': SubscriptionType.free.name,
      'subscriptionStartDate': null,
      'subscriptionEndDate': null,
      'isTrialPeriod': false,
    });
    notifyListeners();
  }

  Future<void> updateProfilePicture(String userId, String photoUrl) async {
    await usersRef.doc(userId).update({
      'photoUrl': photoUrl,
    });
    notifyListeners();
  }

  String handleFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password.';
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'requires-recent-login':
        return 'This operation is sensitive and requires recent authentication. Log in again before retrying this request.';
      default:
        return 'An unknown error occurred.';
    }
  }
}
