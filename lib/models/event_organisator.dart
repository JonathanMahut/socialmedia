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
    data['website'] = website;
    data['totalFollowers'] = totalFollowers;
    data['totalFollowing'] = totalFollowing;
    data['totalPosts'] = totalPosts;
    data['totalFlashes'] = totalFlashes;
    data['theme'] = theme;
    data['language'] = language;
    data['countryCode'] = countryCode;
    data['postalAdress'] = postalAdress;
    data['city'] = city;
    data['secretKey'] = secretKey;
    data['userType'] = userType.name;

    return data;
  }
}
