import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/models/enum/user_type.dart';
import 'package:social_media_app/services/enum_converter.dart';

class UserModel {
  String? username;
  String? email;
  String? photoUrl;
  String? country;
  String? bio;
  String? id;
  Timestamp? signedUpAt;
  Timestamp? lastSeen;
  bool? isOnline;
  String? displayName;
  String? phoneNumber;
  num? totalFollowers;
  num? totalFollowing;
  String? theme;
  String? language;
  String? countryCode;
  String? postalAdress;
  String? city;
  // Use EnumConverter annotation to convert enum to string and vice versa

  @EnumConverter()
  String userType = UserType.UNKNOWN.name; // Use EnumConverter annotation

  UserModel({
    this.username,
    this.email,
    this.id,
    this.photoUrl,
    this.signedUpAt,
    this.isOnline,
    this.lastSeen,
    this.bio,
    this.country,
    this.displayName,
    this.phoneNumber,
    this.totalFollowers,
    this.totalFollowing,
    this.theme,
    this.language,
    this.countryCode,
    this.postalAdress,
    this.city,
    required this.userType,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    country = json['country'];
    photoUrl = json['photoUrl'];
    signedUpAt = json['signedUpAt'];
    isOnline = json['isOnline'];
    lastSeen = json['lastSeen'];
    bio = json['bio'];
    id = json['id'];
    displayName = json['displayName'];
    phoneNumber = json['phoneNumber'];
    totalFollowers = json['totalFollowers'];
    totalFollowing = json['totalFollowing'];
    theme = json['theme'];
    language = json['language'];
    countryCode = json['countryCode'];
    postalAdress = json['postalAdress'];
    city = json['city'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['country'] = country;
    data['email'] = email;
    data['photoUrl'] = photoUrl;
    data['bio'] = bio;
    data['signedUpAt'] = signedUpAt;
    data['isOnline'] = isOnline;
    data['lastSeen'] = lastSeen;
    data['id'] = id;
    data['displayName'] = displayName;
    data['phoneNumber'] = phoneNumber;
    data['totalFollowers'] = totalFollowers;
    data['totalFollowing'] = totalFollowing;
    data['theme'] = theme;
    data['language'] = language;
    data['countryCode'] = countryCode;
    data['postalAdress'] = postalAdress;
    data['city'] = city;
    data['userType'] = userType;

    return data;
  }
}
