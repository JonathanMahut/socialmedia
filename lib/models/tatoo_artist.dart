import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/models/enum/tatoo_style.dart';
import 'package:social_media_app/models/user.dart';

class TatooArtist extends UserModel {
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

  bool? isGuestArtist;
  @override
  String? displayName;
  @override
  String? phoneNumber;

  String? gender;

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
  String? secretKey;
  List<TatooStyle>? tatooStyles;

  TatooArtist({
    this.username,
    this.email,
    this.id,
    this.photoUrl,
    this.signedUpAt,
    this.isOnline,
    this.isGuestArtist,
    this.lastSeen,
    this.bio,
    this.country,
    this.displayName,
    this.phoneNumber,
    this.gender,
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
    this.tatooStyles,
    this.secretKey,
  });

  @override
  TatooArtist.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    country = json['country'];
    photoUrl = json['photoUrl'];
    signedUpAt = json['signedUpAt'];
    isOnline = json['isOnline'];
    isGuestArtist = json['isGuestArtist'];
    lastSeen = json['lastSeen'];
    bio = json['bio'];
    id = json['id'];
    displayName = json['displayName'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
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

    //tatooStyles = json['tatooStyles'].cast<TatooStyle>() ?? [];
    // tatooStyles = json['tatooStyles'];
    if (json.containsKey('tatooStyles') && json['tatooStyles'] != null) {
      tatooStyles = json['tatooStyles'].cast<TatooStyle>() ?? [];
    }
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
    data['isGuestArtist'] = this.isGuestArtist;
    data['lastSeen'] = this.lastSeen;
    data['id'] = this.id;
    data['displayName'] = this.displayName;
    data['phoneNumber'] = this.phoneNumber;
    data['gender'] = this.gender;
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
    data['tatooStyles'] = tatooStyles!.map((style) => style.index).toList();

    return data;
  }
}
