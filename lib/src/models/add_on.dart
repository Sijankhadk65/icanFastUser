import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import './serializer.dart';

part 'add_on.g.dart';

abstract class AddOn implements Built<AddOn, AddOnBuilder> {
  @nullable
  String get name;
  @nullable
  int get price;

  AddOn._();
  factory AddOn([updates(AddOnBuilder b)]) = _$AddOn;

  static Serializer<AddOn> get serializer => _$addOnSerializer;

  Map<String, dynamic> toNewAddOnJson() => {
        "name": this.name,
        "price": this.price,
      };
}

AddOn parseToAddOnModel(Map<String, dynamic> json) {
  return jsonSerializer.deserializeWith(AddOn.serializer, json);
}
