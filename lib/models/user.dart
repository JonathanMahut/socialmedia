import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/models/enum/user_type.dart';

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
  // bool? isArtist;
  String? displayName;
  String? phoneNumber;
  num? totalFollowers;
  num? totalFollowing;
  String? theme;
  String? language;
  String? countryCode;
  String? postalAdress;
  String? city;
  UserType? userType;

  UserModel({
    this.username,
    this.email,
    this.id,
    this.photoUrl,
    this.signedUpAt,
    this.isOnline,
    //  this.isArtist,
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
    this.userType,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    country = json['country'];
    photoUrl = json['photoUrl'];
    signedUpAt = json['signedUpAt'];
    isOnline = json['isOnline'];
    //   isArtist = json['isArtist'];
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
    userType = json['userType'] ?? UserType.CLIENT;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['country'] = this.country;
    data['email'] = this.email;
    data['photoUrl'] = this.photoUrl;
    data['bio'] = this.bio;
    data['signedUpAt'] = this.signedUpAt;
    data['isOnline'] = this.isOnline;
    //  data['isArtist'] = this.isArtist;
    data['lastSeen'] = this.lastSeen;
    data['id'] = this.id;
    data['displayName'] = this.displayName;
    data['phoneNumber'] = this.phoneNumber;
    data['totalFollowers'] = this.totalFollowers;
    data['totalFollowing'] = this.totalFollowing;
    data['theme'] = this.theme;
    data['language'] = this.language;
    data['countryCode'] = this.countryCode;
    data['postalAdress'] = this.postalAdress;
    data['city'] = this.city;
    data['userType'] = this.userType ?? UserType.CLIENT;

    return data;
  }
}
