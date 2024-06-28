import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/utils/firebase.dart';
import 'package:social_media_app/data/models/user.dart';
import 'package:social_media_app/domain/services/services.dart';

import '../../data/models/enum/app_theme.dart';
import '../../data/models/enum/gender_type.dart';
import '../../data/models/enum/subscription_type.dart';
import '../../data/models/enum/user_type.dart';
import '../../data/models/event.dart';
import '../../data/models/product_model.dart';
import '../../data/models/social_media_link_model.dart';

import 'package:social_media_app/core/utils/enum_utils.dart'; // Import the helper methods

class UserService extends Service {
  // Get the authenticated user'sID
  String currentUid() {
    return firebaseAuth.currentUser!.uid;
  }

  // Set user status (online/offline) and update last seen
  Future<void> setUserStatus(bool isOnline) async {
    var user = firebaseAuth.currentUser;
    if (user != null) {
      await usersRef.doc(user.uid).update({
        'isOnline': isOnline,
        'lastSeen': Timestamp.now(),
      });
    }
  }

  // Update user profile
  Future<bool> updateProfile({
    File? image,
    String? username,
    String? bio,
    String? country,
    String? userTypeString,
    String? genderString,
    String? displayName,
    String? phoneNumber,
    String? language,
    String? countryCode,
    String? postalAddress,
    String? city,
    List<String>? specialties,
    AppTheme? theme,
    SubscriptionType? subscriptionType,
    DateTime? subscriptionStartDate,
    DateTime? subscriptionEndDate,
    bool? isTrialPeriod,
    String? portfolioUrl,
    List<EventModel>? organizedEvents,
    String? companyName,
    List<Product>? products,
    String? websiteUrl,
    List<SocialMediaLink>? socialMediaLinks,
  }) async {
    DocumentSnapshot doc = await usersRef.doc(currentUid()).get();
    UserModel currentUser = UserModel.fromJson(doc.data() as Map<String, dynamic>);

    // Convert String? to UserType? and GenderType?
    UserType? userType = userTypeFromString(userTypeString);
    GenderType? gender = genderTypeFromString(genderString);

    UserModel updatedUser = currentUser.copyWith(
      username: username,
      bio: bio,
      country: country,
      userType: userType, // Now using UserType?
      gender: gender, // Now using GenderType?
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

    if (image != null) {
      updatedUser = updatedUser.copyWith(
        photoUrl: await uploadImage(profilePic, image),
      );
    }

    await usersRef.doc(currentUid()).update(updatedUser.toJson());

    return true;
  }

  // Get a user by their ID
  Future<UserModel?> getUserById(String userId) async {
    DocumentSnapshot doc = await usersRef.doc(userId).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  // Follow a user
  Future<void> followUser(String userId) async {
    // Add userId to current user's following list
    await usersRef.doc(currentUid()).update({
      'following': FieldValue.arrayUnion([userId]),
    });

    // Add current user's ID to the followed user's followers list
    await usersRef.doc(userId).update({
      'followers': FieldValue.arrayUnion([currentUid()]),
    });
  }

  // Unfollow a user
  Future<void> unfollowUser(String userId) async {
    // Remove userId from current user's following list
    await usersRef.doc(currentUid()).update({
      'following': FieldValue.arrayRemove([userId]),
    });

    // Remove current user's ID from the unfollowed user's followers list
    await usersRef.doc(userId).update({
      'followers': FieldValue.arrayRemove([currentUid()]),
    });
  }

  // Check if thecurrent user is following another user
  Future<bool> isFollowingUser(String userId) async {
    DocumentSnapshot doc = await usersRef.doc(currentUid()).get();
    UserModel currentUser = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    return currentUser.following.contains(userId);
  }

  // Get followers of a user
  Future<List<UserModel>> getFollowers(String userId) async {
    DocumentSnapshot doc = await usersRef.doc(userId).get();
    UserModel user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    List<UserModel> followers = [];
    for (String followerId in user.followers) {
      UserModel? follower = await getUserById(followerId);
      if (follower != null) {
        followers.add(follower);
      }
    }
    return followers;
  }

  // Get users that a user is following
  Future<List<UserModel>> getFollowing(String userId) async {
    DocumentSnapshot doc = await usersRef.doc(userId).get();
    UserModel user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    List<UserModel> following = [];
    for (String followingId in user.following) {
      UserModel? followedUser = await getUserById(followingId);
      if (followedUser != null) {
        following.add(followedUser);
      }
    }
    return following;
  }
}
