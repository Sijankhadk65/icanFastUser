import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import '../models/serializer.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
  @nullable
  String get email;
  @nullable
  String get name;
  @nullable
  String get photoURI;
  @nullable
  int get phoneNumber;

  factory User([void Function(UserBuilder) updates]) = _$User;
  User._();
  static Serializer<User> get serializer => _$userSerializer;
}

User parseJsonToUser(Map<String, dynamic> json) {
  return jsonSerializer.deserializeWith(User.serializer, json);
}

Map<String, dynamic> convertUserToJson(User user) =>
    {"name": user.name, "email": user.email, "photoURI": user.photoURI};
