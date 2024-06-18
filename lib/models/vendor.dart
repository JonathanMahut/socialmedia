import 'package:social_media_app/models/enum/gender_type.dart';
import 'package:social_media_app/models/enum/user_type.dart';
import 'package:social_media_app/models/user.dart';

class Annoucer extends UserModel {
  String? website;
  num? totalPosts;
  String? secretKey;

  @override
  Annoucer({
    //  this.username,
    super.username,
    super.email,
    super.id,
    super.photoUrl,
    super.signedUpAt,
    super.isOnline,
    super.lastSeen,
    super.bio,
    super.country,
    super.displayName,
    super.phoneNumber,
    this.website,
    super.totalFollowers,
    super.totalFollowing,
    this.totalPosts,
    super.theme,
    super.language,
    super.countryCode,
    super.postalAdress,
    super.city,
    this.secretKey,
    // required super.userType,
  }) : super(userType: UserType.VENDOR.name, gender: GenderType.UNKNOWN.name);

  @override
  Annoucer.fromJson(Map<String, dynamic> json)
      : super(
          userType: UserType.VENDOR.name,
          username: json['username'],
          email: json['email'],
          photoUrl: json['photoUrl'],
          country: json['country'],
          id: json['id'],
          signedUpAt: json['signedUpAt'],
          isOnline: json['isOnline'],
          lastSeen: json['lastSeen'],
          bio: json['bio'],
          displayName: json['displayName'],
          phoneNumber: json['phoneNumber'],
          gender: json['gender'],
          totalFollowers: json['totalFollowers'],
          totalFollowing: json['totalFollowing'],
          theme: json['theme'],
          language: json['language'],
          countryCode: json['countryCode'],
          postalAdress: json['postalAdress'],
          city: json['city'],
        ) {
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

  static get totalFlashes => null;
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
