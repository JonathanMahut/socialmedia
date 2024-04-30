import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/models/enum/user_type.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/services/enum_converter.dart';

class Client extends UserModel {
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
  String? gender;
  @override
  num? totalFollowers;
  @override
  num? totalFollowing;
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
  @override
  @EnumConverter()
  UserType userType = UserType.CLIENT;

  @override
  Client({
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
    this.gender,
    this.totalFollowers,
    this.totalFollowing,
    this.theme,
    this.language,
    this.countryCode,
    this.postalAdress,
    this.city,
    //  required super.userType,
  }) : super(userType: UserType.CLIENT);

  @override
  Client.fromJson(Map<String, dynamic> json)
      : super(userType: UserType.CLIENT) {
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
    gender = json['gender'];
    totalFollowers = json['totalFollowers'];
    totalFollowing = json['totalFollowing'];
    theme = json['theme'];
    language = json['language'];
    countryCode = json['countryCode'];
    postalAdress = json['postalAdress'];
    city = json['city'];
    userType = json['userType'] as UserType? ?? UserType.CLIENT;
  }

  @override
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
    data['gender'] = gender;
    data['totalFollowers'] = totalFollowers;
    data['totalFollowing'] = totalFollowing;
    data['theme'] = theme;
    data['language'] = language;
    data['countryCode'] = countryCode;
    data['postalAdress'] = postalAdress;
    data['city'] = city;
    data['userType'] = UserType.CLIENT.name;

    return data;
  }
}
