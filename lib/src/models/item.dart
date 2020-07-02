import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import './serializer.dart';

part 'item.g.dart';

abstract class MenuItem implements Built<MenuItem, MenuItemBuilder> {
  @nullable
  String get category;
  @nullable
  String get name;
  @nullable
  String get photoURI;
  @nullable
  int get price;
  @nullable
  bool get isAvailable;
  @nullable
  bool get isHotAndNew;
  @nullable
  String get description;
  @nullable
  String get vendor;
  @nullable
  BuiltList<String> get addOn;
  MenuItem._();
  factory MenuItem([updates(MenuItemBuilder b)]) = _$MenuItem;

  static Serializer<MenuItem> get serializer => _$menuItemSerializer;

  Map<String, dynamic> toNewMenuItemJson() => {
        "name": this.name,
        "price": this.price,
        "quantity": 1,
        "totalPrice": this.price,
      };
}

MenuItem parseToMenuItemModel(Map<String, dynamic> json) {
  return jsonSerializer.deserializeWith(MenuItem.serializer, json);
}
