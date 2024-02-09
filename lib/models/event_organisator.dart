import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/models/enum/tatoo_style.dart';

class EventOrganisator {
  String? username;
  String? email;
  String? photoUrl;
  String? country;
  String? bio;
  String? id;
  Timestamp? signedUpAt;
  Timestamp? lastSeen;
  bool? isOnline;
  bool? isArtist;
  String? displayName;
  String? phoneNumber;
  String? gender;
  String? website;
  num? totalFollowers;
  num? totalFollowing;
  num? totalPosts;
  num? totalFlashes;
  String? theme;
  String? language;
  String? countryCode;
  String? postalAdress;
  String? city;
  String? secretKey;
  List<TatooStyle>? tatooStyles;
  EventOrganisator({
    this.username,
    this.email,
    this.id,
    this.photoUrl,
    this.signedUpAt,
    this.isOnline,
    this.isArtist,
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

  EventOrganisator.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    country = json['country'];
    photoUrl = json['photoUrl'];
    signedUpAt = json['signedUpAt'];
    isOnline = json['isOnline'];
    isArtist = json['isArtist'];
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
    data['isArtist'] = this.isArtist;
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
