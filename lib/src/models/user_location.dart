import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import '../models/serializer.dart';

part 'user_location.g.dart';

abstract class UserLocation
    implements Built<UserLocation, UserLocationBuilder> {
  @nullable
  double get lat;
  @nullable
  double get lang;
  @nullable
  String get physicalLocation;

  factory UserLocation([void Function(UserLocationBuilder) updates]) =
      _$UserLocation;
  UserLocation._();
  static Serializer<UserLocation> get serializer => _$userLocationSerializer;
}

UserLocation parseJsonToUserLocation(Map<String, dynamic> json) {
  return jsonSerializer.deserializeWith(UserLocation.serializer, json);
}

Map<String, dynamic> convertUserLocationToJson(UserLocation userLocation) => {
      "lat": userLocation.lat,
      "lang": userLocation.lang,
      "physicalLocation": userLocation.physicalLocation,
    };
