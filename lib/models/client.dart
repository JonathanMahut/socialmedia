import 'package:social_media_app/models/enum/gender_type.dart';
import 'package:social_media_app/models/enum/user_type.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/services/enum_converter.dart';

class Client extends UserModel {
  @EnumConverter()
  String? gender = GenderType.UNKNOWN.name;

  @override
  Client({
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
    this.gender,
    super.totalFollowers,
    super.totalFollowing,
    super.theme,
    super.language,
    super.countryCode,
    super.postalAdress,
    super.city,
  }) : super(
          userType: UserType.CLIENT.name,
          gender: gender,
        );

  @override
  Client.fromJson(Map<String, dynamic> json)
      : super(
          userType: UserType.CLIENT.name,
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
    gender = json['gender'];
    totalFollowers = json['totalFollowers'];
    totalFollowing = json['totalFollowing'];
    theme = json['theme'];
    language = json['language'];
    countryCode = json['countryCode'];
    postalAdress = json['postalAdress'];
    city = json['city'];
    userType = json['userType'];
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
    data['userType'] = userType;

    return data;
  }
}
