import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/data/models/enum/app_theme.dart';
import 'package:social_media_app/data/models/enum/gender_type.dart';
import 'package:social_media_app/data/models/enum/subscription_type.dart';
import 'package:social_media_app/data/models/enum/user_type.dart';
import 'package:social_media_app/data/models/event.dart';
import 'package:social_media_app/data/models/product_model.dart';
import 'package:social_media_app/data/models/social_media_link_model.dart';


class UserModel {
  final String id;
  final String email;
  final String username;
  final UserType userType;
  final String? photoUrl;
  final String? bio;
  final String? country;
  final String? displayName;
  final String? phoneNumber;
  final int totalFollowers;
  final int totalFollowing;
  final String language;
  final String? countryCode;
  final String? postalAddress;
  final String? city;
  final GenderType? gender;
  final List<String>? specialties;
  final Map<String, dynamic>? additionalInfo;
  final AppTheme theme;
  final SubscriptionType subscriptionType;
  final DateTime? subscriptionStartDate;
  final DateTime? subscriptionEndDate;
  final bool isTrialPeriod;
  final List<String> postIds;
  final String? portfolioUrl;
  final List<EventModel>? organizedEvents; // Keep as nullable, use EventModel
  final String? companyName;
  final List<Product>? products;
  final String? websiteUrl;
  final List<SocialMediaLink>? socialMediaLinks;
  final List<String> following;
  final List<String> followers;
  final DateTime signedUpAt;
  final DateTime lastSeen;
  final bool isOnline;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.userType,
    this.photoUrl,
    this.bio,
    this.country,
    this.displayName,
    this.phoneNumber,
    this.totalFollowers = 0,
    this.totalFollowing = 0,
    this.language = 'en',
    this.countryCode,
    this.postalAddress,
    this.city,
    this.gender,
    this.specialties,
    this.additionalInfo,
    this.theme = AppTheme.system,
    this.subscriptionType = SubscriptionType.free,
    this.subscriptionStartDate,
    this.subscriptionEndDate,
    this.isTrialPeriod = false,
    this.postIds = const [],
    this.portfolioUrl,
    this.organizedEvents, // No default value needed
    this.companyName,
    this.products,
    this.websiteUrl,
    this.socialMediaLinks,
    this.following = const [],
    this.followers = const [],
    DateTime? signedUpAt,
    DateTime? lastSeen,
    this.isOnline = false,
  })  : signedUpAt = signedUpAt ?? DateTime.now(),
        lastSeen = lastSeen ?? DateTime.now();

  // Factory constructor for creating a User from JSON (with error handling)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      userType: _userTypeFromString(json['userType'] as String?),
      photoUrl: json['photoUrl'] as String?,
      bio: json['bio'] as String?,
      country: json['country'] as String?,
      displayName: json['displayName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      totalFollowers: (json['totalFollowers'] as num?)?.toInt() ?? 0,
      totalFollowing: (json['totalFollowing'] as num?)?.toInt() ?? 0,
      language: json['language'] as String? ?? 'en',
      countryCode: json['countryCode'] as String?,
      postalAddress: json['postalAddress'] as String?, city: json['city'] as String?,
      gender: _genderTypeFromString(json['gender'] as String?),
      specialties: (json['specialties'] as List?)?.cast<String>(),
      additionalInfo: json['additionalInfo'] as Map<String, dynamic>?,
      theme: _appThemeFromString(json['theme'] as String?),
      subscriptionType: _subscriptionTypeFromString(json['subscriptionType'] as String?),
      subscriptionStartDate: (json['subscriptionStartDate'] as Timestamp?)?.toDate(),
      subscriptionEndDate: (json['subscriptionEndDate'] as Timestamp?)?.toDate(),
      isTrialPeriod: json['isTrialPeriod'] as bool? ?? false,
      postIds: (json['postIds'] as List?)?.cast<String>() ?? const [],
      portfolioUrl: json['portfolioUrl'] as String?,
      organizedEvents: (json['organizedEvents'] as List?)
          ?.map((e) => EventModel.fromJson(e as Map<String, dynamic>))
          .toList(), // Handle potential null
      companyName: json['companyName'] as String?,
      products: (json['products'] as List?)?.map((e) => Product.fromJson(e as Map<String, dynamic>)).toList(),
      websiteUrl: json['websiteUrl'] as String?,
      socialMediaLinks:
          (json['socialMediaLinks'] as List?)?.map((e) => SocialMediaLink.fromJson(e as Map<String, dynamic>)).toList(),
      following: (json['following'] as List?)?.cast<String>() ?? const [],
      followers: (json['followers'] as List?)?.cast<String>() ?? const [],
      signedUpAt: (json['signedUpAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      lastSeen: (json['lastSeen'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isOnline: json['isOnline'] as bool? ?? false,
    );
  }

// ... (rest of the class remains the same: toJson, copyWith, helper methods, computed properties, canAccessFeature)

  // Method to convert a User to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'userType': userType.name,
      'photoUrl': photoUrl,
      'bio': bio,
      'country': country,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'totalFollowers': totalFollowers,
      'totalFollowing': totalFollowing,
      'language': language,
      'countryCode': countryCode,
      'postalAddress': postalAddress,
      'city': city,
      'gender': gender?.name,
      'specialties': specialties,
      'additionalInfo': additionalInfo,
      'theme': theme.name,
      'subscriptionType': subscriptionType.name,
      'subscriptionStartDate': subscriptionStartDate,
      'subscriptionEndDate': subscriptionEndDate,
      'isTrialPeriod': isTrialPeriod,
      'postIds': postIds,
      'portfolioUrl': portfolioUrl,
      'organizedEvents': organizedEvents?.map((e) => e.toJson()).toList(),
      'companyName': companyName,
      'products': products?.map((e) => e.toJson()).toList(),
      'websiteUrl': websiteUrl,
      'socialMediaLinks': socialMediaLinks?.map((e) => e.toJson()).toList(),
      'following': following,
      'followers': followers,
      'signedUpAt': Timestamp.fromDate(signedUpAt),
      'lastSeen': Timestamp.fromDate(lastSeen),
      'isOnline': isOnline,
    };
  }

  // Method to create a copy of a User with optional modifications
  UserModel copyWith({
    String? id,
    String? email,
    String? username,
    UserType? userType,
    String? photoUrl,
    String? bio,
    String? country,
    String? displayName,
    String? phoneNumber,
    int? totalFollowers,
    int? totalFollowing,
    String? language,
    String? countryCode,
    String? postalAddress,
    String? city,
    GenderType? gender,
    List<String>? specialties,
    Map<String, dynamic>? additionalInfo,
    AppTheme? theme,
    SubscriptionType? subscriptionType,
    DateTime? subscriptionStartDate,
    DateTime? subscriptionEndDate,
    bool? isTrialPeriod,
    List<String>? postIds,
    String? portfolioUrl,
    List<EventModel>? organizedEvents,
    String? companyName,
    List<Product>? products,
    String? websiteUrl,
    List<SocialMediaLink>? socialMediaLinks,
    List<String>? following,
    List<String>? followers,
    DateTime? signedUpAt,
    DateTime? lastSeen,
    bool? isOnline,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      userType: userType ?? this.userType,
      photoUrl: photoUrl ?? this.photoUrl,
      bio: bio ?? this.bio,
      country: country ?? this.country,
      displayName: displayName ?? this.displayName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      totalFollowers: totalFollowers ?? this.totalFollowers,
      totalFollowing: totalFollowing ?? this.totalFollowing,
      language: language ?? this.language,
      countryCode: countryCode ?? this.countryCode,
      postalAddress: postalAddress ?? this.postalAddress,
      city: city ?? this.city,
      gender: gender ?? this.gender,
      specialties: specialties ?? this.specialties,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      theme: theme ?? this.theme,
      subscriptionType: subscriptionType ?? this.subscriptionType,
      subscriptionStartDate: subscriptionStartDate ?? this.subscriptionStartDate,
      subscriptionEndDate: subscriptionEndDate ?? this.subscriptionEndDate,
      isTrialPeriod: isTrialPeriod ?? this.isTrialPeriod,
      postIds: postIds ?? this.postIds,
      portfolioUrl: portfolioUrl ?? this.portfolioUrl,
      organizedEvents: organizedEvents ?? this.organizedEvents,
      companyName: companyName ?? this.companyName,
      products: products ?? this.products,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      socialMediaLinks: socialMediaLinks ?? this.socialMediaLinks,
      following: following ?? this.following,
      followers: followers ?? this.followers,
      signedUpAt: signedUpAt ?? this.signedUpAt,
      lastSeen: lastSeen ?? this.lastSeen,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  // Helper methods to convert strings to enums
  static UserType _userTypeFromString(String? userTypeString) {
    if (userTypeString != null) {
      try {
        return UserType.values.byName(userTypeString);
      } catch (e) {
        print('Invalid UserType: $userTypeString');
      }
    }
    return UserType.unknown; // Default value
  }

  static GenderType? _genderTypeFromString(String? genderString) {
    if (genderString != null) {
      try {
        return GenderType.values.byName(genderString);
      } catch (e) {
        print('InvalidGenderType: $genderString');
      }
    }
    return null; // Allow null for GenderType
  }

  static AppTheme _appThemeFromString(String? appThemeString) {
    if (appThemeString != null) {
      try {
        return AppTheme.values.byName(appThemeString);
      } catch (e) {
        print('Invalid AppTheme: $appThemeString');
      }
    }
    return AppTheme.system; // Default value
  }

  static SubscriptionType _subscriptionTypeFromString(String? subscriptionTypeString) {
    if (subscriptionTypeString != null) {
      try {
        return SubscriptionType.values.byName(subscriptionTypeString);
      } catch (e) {
        print('Invalid SubscriptionType: $subscriptionTypeString');
      }
    }
    return SubscriptionType.free; // Default value
  }

  // Computed properties
  bool get isPremium => subscriptionType != SubscriptionType.free;

  bool get isSubscriptionActive {
    if (subscriptionType == SubscriptionType.free) return true;
    final now = DateTime.now();
    return subscriptionEndDate != null && subscriptionEndDate!.isAfter(now);
  }

  int getRemainingDays() {
    if (subscriptionType == SubscriptionType.free) return -1;
    final now = DateTime.now();
    return subscriptionEndDate != null ? subscriptionEndDate!.difference(now).inDays : 0;
  }

  // Method to check feature access based on subscription type
  bool canAccessFeature(String featureName) {
    // Logic to determine feature access based on subscription type
    // ...
    return false; // Replace with your actual logic
  }
}
