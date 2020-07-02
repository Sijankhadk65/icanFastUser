import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import './serializer.dart';

part 'carousel_item.g.dart';

abstract class CarouselItem
    implements Built<CarouselItem, CarouselItemBuilder> {
  @nullable
  String get carouselID;
  @nullable
  bool get isActive;
  @nullable
  bool get isInteractive;
  @nullable
  String get photoURI;
  @nullable
  String get vendor;
  CarouselItem._();
  factory CarouselItem([updates(CarouselItemBuilder b)]) = _$CarouselItem;
  static Serializer<CarouselItem> get serializer => _$carouselItemSerializer;
}

CarouselItem parseToCarouselItem(Map<String, dynamic> json) {
  return jsonSerializer.deserializeWith(CarouselItem.serializer, json);
}
