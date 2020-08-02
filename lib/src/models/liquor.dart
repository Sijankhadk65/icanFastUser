import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import './serializer.dart';

part 'liquor.g.dart';

abstract class Liquor implements Built<Liquor, LiquorBuilder> {
  @nullable
  String get type;
  @nullable
  String get createdAt;
  @nullable
  String get name;
  @nullable
  String get photoURI;
  @nullable
  int get price;
  @nullable
  bool get isAvailable;
  @nullable
  bool get isFeatured;
  @nullable
  String get description;
  Liquor._();
  factory Liquor([updates(LiquorBuilder b)]) = _$Liquor;

  static Serializer<Liquor> get serializer => _$liquorSerializer;

  Map<String, dynamic> toNewLiquorJson() => {
        "name": this.name,
        "price": this.price,
        "quantity": 1,
        "totalPrice": this.price,
      };
}

Liquor parseToLiquorModel(Map<String, dynamic> json) {
  return jsonSerializer.deserializeWith(Liquor.serializer, json);
}
