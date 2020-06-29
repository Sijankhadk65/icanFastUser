import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import '../models/user.dart';

import 'serializer.dart';

part 'rating.g.dart';

abstract class Rating implements Built<Rating, RatingBuilder> {
  @nullable
  String get comment;
  @nullable
  User get user;
  @nullable
  double get rating;
  @nullable
  String get createdAt;
  Rating._();
  factory Rating([updates(RatingBuilder b)]) = _$Rating;
  static Serializer<Rating> get serializer => _$ratingSerializer;
}

Rating parseJsonToRating(Map<String, dynamic> json) =>
    jsonSerializer.deserializeWith(Rating.serializer, json);
