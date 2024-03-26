import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/models/enum/user_type.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/services/enum_converter.dart';

class EventOrganisator extends UserModel {
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

  num? totalFlashes;
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
  UserType userType = UserType.EVENTORGANISATOR;

  String? secretKey;

  @override
  EventOrganisator({
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
    this.totalFlashes,
    this.theme,
    this.language,
    this.countryCode,
    this.postalAdress,
    this.city,
    this.secretKey,
    //required this.userType,
  }) : super(userType: UserType.EVENTORGANISATOR);

  @override
  EventOrganisator.fromJson(Map<String, dynamic> json)
      : super(userType: UserType.EVENTORGANISATOR) {
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
    totalFlashes = json['totalFlashes'];
    theme = json['theme'];
    language = json['language'];
    countryCode = json['countryCode'];
    postalAdress = json['postalAdress'];
    city = json['city'];
    secretKey = json['secretKey'];
    super.userType = json['userType'] as UserType? ?? UserType.EVENTORGANISATOR;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['country'] = this.country;
    data['email'] = this.email;
    data['photoUrl'] = this.photoUrl;
    data['bio'] = this.bio;
    data['signedUpAt'] = this.signedUpAt;
    data['isOnline'] = this.isOnline;
    data['lastSeen'] = this.lastSeen;
    data['id'] = this.id;
    data['displayName'] = this.displayName;
    data['phoneNumber'] = this.phoneNumber;
    data['website'] = this.website;
    data['totalFollowers'] = this.totalFollowers;
    data['totalFollowing'] = this.totalFollowing;
    data['totalPosts'] = this.totalPosts;
    data['totalFlashes'] = this.totalFlashes;
    data['theme'] = this.theme;
    data['language'] = this.language;
    data['countryCode'] = this.countryCode;
    data['postalAdress'] = this.postalAdress;
    data['city'] = this.city;
    data['secretKey'] = this.secretKey;
    data['userType'] = this.userType.name;

    return data;
  }
}
