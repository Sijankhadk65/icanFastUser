import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fastuserapp/src/models/user_location.dart';
import '../models/serializer.dart';

part 'user.g.dart';

abstract class FastUser implements Built<FastUser, FastUserBuilder> {
  @nullable
  String get email;
  @nullable
  String get name;
  @nullable
  String get photoURI;
  @nullable
  int get phoneNumber;
  @nullable
  UserLocation get home;
  @nullable
  UserLocation get office;
  @nullable
  bool get isVerified;
  @nullable
  BuiltList<String> get promoCodes;

  factory FastUser([void Function(FastUserBuilder) updates]) = _$FastUser;
  FastUser._();
  static Serializer<FastUser> get serializer => _$fastUserSerializer;
}

FastUser parseJsonToUser(Map<String, dynamic> json) {
  return jsonSerializer.deserializeWith(FastUser.serializer, json);
}

Map<String, dynamic> convertUserToJson(FastUser user) =>
    {"name": user.name, "email": user.email, "photoURI": user.photoURI};
