import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import './serializer.dart';

part 'offers_item.g.dart';

abstract class OffersItem implements Built<OffersItem, OffersItemBuilder> {
  @nullable
  String get createdAt;
  @nullable
  bool get isActive;
  @nullable
  String get photoURI;
  @nullable
  String get vendor;
  @nullable
  int get price;
  @nullable
  String get description;
  @nullable
  String get name;
  OffersItem._();
  factory OffersItem([updates(OffersItemBuilder b)]) = _$OffersItem;
  static Serializer<OffersItem> get serializer => _$offersItemSerializer;
}

OffersItem parseToOffersItem(Map<String, dynamic> json) {
  return jsonSerializer.deserializeWith(OffersItem.serializer, json);
}
