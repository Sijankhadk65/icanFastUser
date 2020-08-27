import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import './serializer.dart';

part 'varient.g.dart';

abstract class Varient implements Built<Varient, VarientBuilder> {
  @nullable
  String get name;
  @nullable
  int get price;

  Varient._();
  factory Varient([updates(VarientBuilder b)]) = _$Varient;

  static Serializer<Varient> get serializer => _$varientSerializer;

  Map<String, dynamic> toNewVarientJson() => {
        "name": this.name,
        "price": this.price,
      };
}

Varient parseToVarientModel(Map<String, dynamic> json) {
  return jsonSerializer.deserializeWith(Varient.serializer, json);
}
