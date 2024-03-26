import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/models/enum/user_type.dart';

class EnumConverter extends JsonConverter<UserType, String> {
  const EnumConverter();

  @override
  String toJson(UserType enumValue) => enumValue.toString();

  @override
  UserType fromJson(String jsonString) => UserType.values.byName(jsonString);
}
