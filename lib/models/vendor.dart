import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/models/enum/user_type.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/services/enum_converter.dart';

class Annoucer extends UserModel {
  @override
  String? username;
  @override
  String? email;
  @override
  String? photoUrl;
  @override
  String? country;
  @override
  String? bio;
  @override
  String? id;
  @override
  Timestamp? signedUpAt;
  @override
  Timestamp? lastSeen;
  @override
  bool? isOnline;
  @override
  String? displayName;
  @override
  String? phoneNumber;
  String? website;
  @override
  num? totalFollowers;
  @override
  num? totalFollowing;

  num? totalPosts;
  @override
  String? theme;
  @override
  String? language;
  @override
  String? countryCode;
  @override
  String? postalAdress;
  @override
  String? city;
  String? secretKey;
  @override
  @EnumConverter()
  UserType userType = UserType.VENDOR;

  @override
  Annoucer({
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
    this.website,
    this.totalFollowers,
    this.totalFollowing,
    this.totalPosts,
    this.theme,
    this.language,
    this.countryCode,
    this.postalAdress,
    this.city,
    this.secretKey,
    // required super.userType,
  }) : super(userType: UserType.VENDOR);

  @override
  Annoucer.fromJson(Map<String, dynamic> json)
      : super(userType: UserType.VENDOR) {
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
    website = json['website'];
    totalFollowers = json['totalFollowers'];
    totalFollowing = json['totalFollowing'];
    totalPosts = json['totalPosts'];
    theme = json['theme'];
    language = json['language'];
    countryCode = json['countryCode'];
    postalAdress = json['postalAdress'];
    city = json['city'];
    secretKey = json['secretKey'];
    userType = json['userType'];
  }
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['website'] = website;
    data['totalFollowers'] = totalFollowers;
    data['totalFollowing'] = totalFollowing;
    data['totalPosts'] = totalPosts;
    data['theme'] = theme;
    data['language'] = language;
    data['countryCode'] = countryCode;
    data['postalAdress'] = postalAdress;
    data['city'] = city;
    data['secretKey'] = secretKey;
    data['userType'] = userType;
    return data;
  }
}
