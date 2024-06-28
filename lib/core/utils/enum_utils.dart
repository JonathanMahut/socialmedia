import 'package:social_media_app/data/models/enum/gender_type.dart';
import 'package:social_media_app/data/models/enum/user_type.dart';

// Helper method to convert a string to UserType enum
UserType? userTypeFromString(String? userTypeString) {
  if (userTypeString != null) {
    try {
      return UserType.values.byName(userTypeString);
    } catch (e) {
      print('Invalid UserType: $userTypeString');
    }
  }
  return null;
}

// Helper method to convert a string to GenderTypeenum
GenderType? genderTypeFromString(String? genderString) {
  if (genderString != null) {
    try {
      return GenderType.values.byName(genderString);
    } catch (e) {
      print('Invalid GenderType: $genderString');
    }
  }
  return null;
}
