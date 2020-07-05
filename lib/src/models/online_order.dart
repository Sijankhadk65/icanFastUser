import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'cart_items.dart';
import 'serializer.dart';

part 'online_order.g.dart';

abstract class OnlineOrder implements Built<OnlineOrder, OnlineOrderBuilder> {
  @nullable
  int get totalPrice;
  @nullable
  String get refID;
  @nullable
  int get cartLength;
  @nullable
  BuiltList<String> get status;
  @nullable
  String get createdAt;
  @nullable
  String get vendor;
  @nullable
  BuiltList<CartItem> get items;

  OnlineOrder._();
  factory OnlineOrder([updates(OnlineOrderBuilder b)]) = _$OnlineOrder;
  static Serializer<OnlineOrder> get serializer => _$onlineOrderSerializer;
}

OnlineOrder parseJsonToOnlineOrder(Map<String, dynamic> json) =>
    jsonSerializer.deserializeWith(OnlineOrder.serializer, json);

Map<String, dynamic> onlineOrderToJson(OnlineOrder order) => {
      "totalPrice": order.totalPrice,
      "cartLength": order.cartLength,
      "status": order.status.toList(),
      "createdAt": order.createdAt,
      "vendor": order.vendor,
      "items": order.items.toList().map((e) => e.toJson()).toList(),
    };
